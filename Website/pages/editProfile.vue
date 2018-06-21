<template>
    <div class="root" v-if="account">
        <v-form class="edit-form" v-model="valid">
            <input type="file" ref="fileInput" style="display: none" accept="image/*" @change="onNewImageSelected">
            <div class="header">
                <v-avatar :size="130">
                    <img :src="profilePicture">
                </v-avatar>
                <v-btn outline small @click="onChangePictureRequest">Change picture</v-btn>
            </div>
            <v-text-field v-model="accountData.firstName" label="First name" @input="() => valueChanged = true"></v-text-field>
            <v-text-field v-model="accountData.lastName" label="Last name" @input="() => valueChanged = true"></v-text-field>
            <v-text-field type="email" :error-messages="errors.email" v-model="accountData.email" label="Email" @input="() => valueChanged = true" :rules="[isValidEmail]"></v-text-field>
            <gender-selector v-model="accountData.isMale" @input="() => valueChanged = true"></gender-selector>
            <v-text-field type="date" v-model="accountData.birthdate" label="Birthdate" @input="() => valueChanged = true"></v-text-field>
            <v-text-field type="number" v-model="accountData.weight" label="Weight" @input="() => valueChanged = true"></v-text-field>
            <v-text-field type="number" v-model="accountData.height" label="Height" @input="() => valueChanged = true" :rules="[heightIsInt]"></v-text-field>
            <v-text-field textarea v-model="accountData.description" label="Description" @input="() => valueChanged = true"></v-text-field>
            <loading-button 
                class="update-button" 
                @click="onUpdateRequest" 
                :loading="updating"
            >Update</loading-button>
        </v-form>
        <v-snackbar
            bottom
            left
            v-model="snackbar"
        >
            Account was successfully updated
            <v-btn flat color="primary" @click.native="snackbar = false">Close</v-btn>
        </v-snackbar>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
import { getMyRecipes } from "@/assets/account";
import GenderSelector from "@/components/genderSelector.vue";
import LoadingButton from "@/components/loadingButton.vue";
import EmailValidator from "email-validator";
import _ from "lodash";
import moment from "moment";

export default {
    computed:{
        ...mapGetters({
            account: "account/account",
            authenticating: "account/authenticating"
        }),
        accountDataKeys(){
            return Object.keys(this.accountData);
        }
    },
    data(){
        return {
            valid: false,
            recipes: [],
            snackbar: false,
            errors:{
                email: []
            },
            accountData: {
                firstName: "",
                lastName: "",
                email: "",
                isMale: true,
                birthdate: "",
                weight: 0,
                height: 0,
                description: ""
            },
            profilePicture: "",
            valueChanged: false,
            updating: false
        };
    },
    components: {
        GenderSelector,
        LoadingButton
    },
    watch:{
        account(val){
            if(!val)
                this.redirectToLogin();
        },
        authenticating(val){
            if(!val && !this.account)
                this.redirectToLogin();
            else {
                if(!this.account)
                    this.redirectToLogin();
                else {
                    this.fillData();
                }
            }
        }
    },
    mounted(){
        if(this.account)
            this.fillData();
    },
    methods:{
        fillData(){
            const _accountData = _.pick(this.account, [
                "firstName",
                "lastName",
                "email",
                "isMale",
                "birthdate",
                "weight",
                "height",
                "description"
            ]);
            _accountData.isMale = true;
            this.profilePicture = this.account.profilePicture;
            _accountData.birthdate = moment(_accountData.birthdate).format("YYYY-MM-DD");
            Object.keys(_accountData).forEach(key => {
                this.accountData[key] = _accountData[key];
            });
        },
        heightIsInt(height){
            return height % 1 === 0 || "Height has to be an integer";
        },
        isValidEmail(email){
            return EmailValidator.validate(email) || "Email is not valid";
        },
        onChangePictureRequest(){
            const fileInput = this.$refs.fileInput;
            fileInput.click();
        },
        onNewImageSelected(){
            this.valueChanged = true;
            const file = this.$refs.fileInput.files[0];
            const fileReader = new FileReader();
            fileReader.onload = event => {
                this.profilePicture = fileReader.result;
            }
            fileReader.readAsDataURL(this.$refs.fileInput.files[0]);
        },
        onUpdateRequest(){
            Object.keys(this.errors).forEach(key => {
                this.$set(this.errors, key, []);
            })
            this.updating = true;
            const fileInput = this.$refs.fileInput;
            const file = fileInput.files[0];
            let fileWasUploaded = false;
            let accountWasUpdated = false;
            if(file){
                console.log("yes");
                this.$store.dispatch("account/uploadProfilePicture", file)
                .finally(res => {
                    fileWasUploaded = true;
                    if(accountWasUpdated)
                        this.updating = false;
                });
            }
            else fileWasUploaded = true;
            const putData = Object.assign({}, this.account, this.accountData);
            if(putData.birthdate == "Invalid date")
                putData.birthdate = null;
            if(putData.email == this.account.email)
                putData.email = null;
            this.$store.dispatch("account/update", putData)
            .then(res => {
                this.snackbar = true;
            })
            .catch(err => {
                console.log(err);
                if(err.response){
                    if(err.response.status === 409){
                        this.errors.email.push("Email is already being used")
                    }
                }
                else{
                    console.log("network error");
                }
            })
            .finally(res => {
                accountWasUpdated = true;
                if(fileWasUploaded)
                    this.updating = false;
            });
        },
        redirectToLogin(){
            this.$router.push({
                path: "/login",
                query: {
                    redirectPath: this.$route.path
                }
            })
        },
        kebabCase(str){
            return _.kebabCase(str);
        }
    }
}
</script>

<style scoped>
.root{
    height: 100%;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.edit-form{
    width: 50%;
    display: flex;
    flex-direction: column;
}
.header{
    margin: 0 auto;
    padding: 20px 0;
}
.update-button{
    margin-left: auto;
}
</style>
