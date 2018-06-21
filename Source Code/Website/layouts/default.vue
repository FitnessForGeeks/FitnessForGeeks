<template>
    <div class="page">
        <div>
            <v-app class="app">
                <navbar></navbar>
                <nuxt class="page-component"></nuxt>
            </v-app>
        </div>
    </div>
</template>
<script>
import navbar from "@/components/navbar.vue";
import { mapGetters } from "vuex";

export default {
    data(){
        return {
        }
    },
    computed:{
        ...mapGetters({
            account: "account/account"
        })
    },
    mounted(){
        this.$store.dispatch("account/authenticate")
        .catch(err => {
            if(err.request.status === 0){
                console.log(err.message)
            }
        })
    },
    components:{
        navbar
    }
}
</script>
<style scoped>
.page-component {
    margin-top: 68px;
}
.fade-enter-active, .fade-leave-active {
    transition: opacity .5s
}
.fade-enter, .fade-leave-to /* .fade-leave-active in <2.1.8 */ {
    opacity: 0
}
.page{
    height: 100vh;
}
.loading-screen{
    width: 100%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}
.wrapper{
    display: flex;
    flex-direction: column;
    justify-content: center;
}
.spinner{
    margin: 20px auto;
}
.wrapper span{
    font-size: 60px;
    margin-bottom: 10px;
}
.wrapper p{
    text-align: center;
    font-size: 20px;
    color: #9E9E9E;
}
</style>
