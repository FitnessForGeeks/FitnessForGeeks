<template>
    <v-toolbar dense dark flat class="navbar" fixed>
        <v-toolbar-title class="margin-right"> FitnessForGeeks </v-toolbar-title>
        <v-toolbar-items>
            <v-btn v-for="(route, i) in this.routes" :key="i" :to="route.path" nuxt flat>
                 {{ route.name }}
            </v-btn>
        </v-toolbar-items>
        <v-toolbar-items v-if="this.loggedIn" class="align-right">
            <v-menu dark offset-y min-width="300">
                <div slot="activator">
                    <span class="dropdown-btn margin-right"> 
                        {{account.username}} <v-icon class="dropdown-arrow-username">arrow_drop_down</v-icon>
                    </span>
                    <v-avatar>
                        <img class="user-avatar" ref="img" :src="account.profilePicture">
                    </v-avatar>
                </div>
                <v-list >
                    <v-list-tile>
                        <div class="calories-progress">
                            <span class="dropdown-text">Remaining calories<span style="margin-left: auto">{{account.remainingCalories}}</span> </span>
                            <v-progress-linear :value="caloriesProgress"></v-progress-linear>
                        </div>
                    </v-list-tile>
                    <v-list-tile></v-list-tile>
                    <v-divider></v-divider>
                    <v-list-tile v-for="(btn, i) in dropdownButtons" :key="i" @click="btn.onClick">
                        <span class="dropdown-text">
                            {{btn.text}} <v-icon class="dropdown-menu-icon">{{btn.icon}}</v-icon>
                        </span>
                    </v-list-tile>
                </v-list>
            </v-menu>
        </v-toolbar-items>
        <v-toolbar-items v-if="!this.loggedIn" class="align-right">
            <v-btn nuxt flat exact @click="goToLogin"> login </v-btn>
            <v-btn nuxt flat exact to="register"> register </v-btn>
        </v-toolbar-items>
    </v-toolbar>
</template>

<script>
import { mapGetters } from "vuex";

export default {
    computed: {
        ...mapGetters({
            account: "account/account"
        }),
        loggedIn(){
            return this.account != null;
        },
        caloriesProgress(){
            const prog = this.account.remainingCalories / this.account.tdee * 100;
            return prog < 0 ? 0 : prog;
        }
    },
    methods:{
        logOut(){
            this.$store.dispatch("account/logOut");
        },
        goToLogin(){
            this.$router.push({
                path: "login",
                query: {
                    redirectPath: this.$route.path
                }
            })
        }
    },
    data(){
        return {
            routes: [
                {
                    path: "/",
                    name: "Home"
                },
                {
                    path: "/recipes",
                    name: "Recipes"
                }
            ],
            dropdownButtons: [
                {
                    text: "Overview",
                    icon: "book",
                    onClick: () => this.$router.push("overview")
                },
                {
                    text: "My Recipes",
                    icon: "list",
                    onClick: () => this.$router.push("myRecipes")
                },
                {
                    text: "Edit profile",
                    icon: "edit",
                    onClick: () => this.$router.push("editProfile")
                },
                {
                    text: "Go to profile",
                    icon: "person",
                    onClick: () => this.$router.push("profilePage")
                },
                {
                    text: "Log out",
                    icon: "arrow_forward",
                    onClick: this.logOut
                },
            ]
        }
    }
}
</script>

<style scoped>
.dropdown-arrow-username{
    margin-bottom: 5px;
}
.calories-progress{
    padding-top: 50px;
    display: flex;
    width: 100%;
    flex-direction: column;
}
.dropdown-menu-icon{
    margin-left: auto;
}
.dropdown-text{
    display: flex;
    width: 100%;
    font-size: 18px;
}
.navbar{
    padding: 10px 0;
}
.margin-right {
    margin-right: 10px;
}
.align-right{
    margin-left: auto;
}
.user-avatar{
    width: 44px;
    height: 44px;
    cursor: pointer;
}
</style>
