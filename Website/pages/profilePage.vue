<template>
  <v-container v-if="account">
    <div class="header"> 
        <div class="avatar">
            <v-avatar size="200"> 
            <img id="avatarId" :src="account.profilePicture" alt="Avatar">
            </v-avatar>
            <p class="names">
                <span class="username">Username</span>   
                <span class="fullname">{{account.firstName}} {{account.lastName}}</span>
            </p>
        </div>
        <div class="description">
            <p>{{account.description}}</p>
        </div>
    </div> 
    <div class="values">
        <span class="value">
            <span class="value-title">
                Height:    
            </span>
            <span class="value-content">
                {{account.height}} cm
            </span>
        </span>
        <span class="value">
            <span class="value-title">
                Weight:    
            </span>
            {{account.weight}} kg
            </span>
        </span>
        <span class="value">
            <span class="value-title">
                Age:    
            </span>
            <span class="value-content">
            {{account.age}} 
            </span>
        </span>
        <span class="value">
            <span class="value-title">
                Gender:    
            </span>
            <span class="value-content">
                {{gender}}
            </span>
        </span>
        <span class="value">
            <span class="value-title">
                Birthday:    
            </span>
            <span class="value-content">
            {{formatedBirthdate}} 
            </span>
        </span>
    </div>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import moment from "moment";

export default {
    data(){
        return {
            gender: "Female"
        }
    },
    computed:{
        ...mapGetters({
            account: "account/account",
            authenticating: "account/authenticating"
        }),
        formatedBirthdate(){
            return moment(this.account.birthdate).format("DD-MM-YYYY");
        },
        redirectToLogin(){
            this.$router.push({
                path: "/login",
                query: {
                    redirectPath: "/overview"
                }
            })
        }
    },
    watch:{
        account(val){
            if(!val)
                this.redirectToLogin();
            else
                this.gender = val.isMale? "Male" : "Female"
        },
        authenticating(val){
            if(!val && !this.account)
                this.redirectToLogin();
            else {
                if(!this.account)
                    this.redirectToLogin();
            }
        }
    },
};
</script>

<style scoped>
.fullname{
    font-size: 12px;
}

.header{
    display: flex;
}

.username{
    font-size: 25px;
    margin: 0 auto;
}

.description{
    width: 100%;
    padding: 80px;
}

.avatar{
    display: flex;
    flex-direction: column;
}
.names{
    display: flex;
    flex-direction: column;
}

.value-title{
    margin-right: 20px;
    font-size: 20px;
}

.value{
    width: 100%;
}

.values{
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding-top: 100px;
    padding-left: 100px;
}

.value-content{
    font-size: 15px;
}

</style>
