<template>
    <v-container v-if="!account">
        <v-card dense class="signup-form">
            <v-card-text>
                <v-form v-model="valid" @keydown.enter.native="submit">
                    <v-text-field
                        autofocus
                        label="Username"
                        v-model="username"
                        :rules="[rules.required('Username')]"
                        prepend-icon="person"
                        :error-messages="errors.username"
                        required
                    ></v-text-field>
                    <v-text-field
                        label="Email"
                        v-model="email"
                        type="email"
                        :rules="[rules.required('Email'), rules.email]"
                        prepend-icon="email"
                        :error-messages="errors.email"
                        required
                    ></v-text-field>
                    <v-text-field
                        label="Password"
                        v-model="password"
                        type="password"
                        :rules="[rules.required('Password')]"
                        prepend-icon="lock"
                        required
                    ></v-text-field>
                    <v-text-field
                        label="Confirm Password"
                        type="password"
                        :rules="[rules.required('Confirm Password'), rules.equals('password')]"
                        prepend-icon="lock"
                        required
                    ></v-text-field>
                    <v-btn 
                        ref="submitButton" 
                        :disabled="!valid" 
                        @click="submit"
                        color="primary"
                        class="signup-button"
                    > register </v-btn>
                </v-form>
            </v-card-text>
        </v-card>
    </v-container>  
</template>

<script>
import { register } from "@/assets/account.js";
import { mapGetters } from "vuex";
import EmailValidator from "email-validator";

export default {
    created(){
        if(this.account){
            this.$router.push("/");
        }
    },
    watch:{
        account(val){
            if(val)
                this.$router.push("/");
        },
        authenticating(val){
            if(!val && this.account)
                this.$router.push("/");
            else if(this.account)
                this.$router.push("/");
            
        }
    },
    data(){
        return {
            username: "",
            password: "",
            errors: {
                username: [],
                email: []
            },
            email: "",
            valid: false,
            rules: {
                required: name => val => {
                    if(val === "")
                        return name + " is required";
                    return true;
                },
                equals: name => val => {
                    if(val !== this[name])
                        return "Does not match " + name;
                    return true;
                },
                email: val => {
                    if(!EmailValidator.validate(val))
                        return "Must be a valid email"
                    return true;
                }
            }
        }
    },
    methods:{
        submit(){
            if(this.valid){
                this.errors.username = [];
                this.errors.email = [];
                register(
                    this.username,
                    this.password,
                    this.email
                )
                .then(response => {
                    this.$router.push("/login");
                })
                .catch(error => {
                    const { status, data } = error.response;
                    if(status === 409){
                        if(data.field === "username"){
                            this.errors.username.push("Username is already taken");
                        }
                        else if(data.field === "email"){
                            this.errors.email.push("Email is already being used");
                        }
                    }
                })
            }
        }
    },
    computed:{
        ...mapGetters({
            account: "account/account"
        })
    }
}
</script>

<style scoped>
.signup-form{
    width: 400px;
    margin: 200px auto;
}
.signup-button{
    margin-left: 272px;
}
</style>
