<template>
    <div class="root">
        <recipe-form
            :recipe="recipe"
            submit-value="Update"
            :errors="errors"
            @submit="updateRecipe"
        ></recipe-form>
        <v-snackbar
            bottom
            left
            v-model="snackbar"
        >
            Recipe was successfully updated
            <v-btn flat color="primary" @click.native="snackbar = false">Close</v-btn>
        </v-snackbar>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
import RecipeForm from "@/components/recipeForm.vue";
import { update, uploadRecipePicture } from "@/assets/recipe";

export default {
    computed:{
        ...mapGetters({
            account: "account/account",
            authenticating: "account/authenticating",
        })
    },
    created(){
        if(!this.$route.params.recipe)
            this.$router.push("/myRecipes");
        else
            this.recipe = JSON.parse(this.$route.params.recipe);
        console.log(this.recipe);
    },
    data(){
        return {
            recipe: {},
            snackbar: false,
            errors: {
                title: []
            }
        };
    },
    components:{
        RecipeForm
    },
    watch:{
        account(val){
            if(!val)
                this.redirectToLogin();
        },
        authenticating(val){
            if(!val && !this.account)
                this.redirectToLogin();
            else if(!this.account)
                this.redirecttologin();
            
        }
    },
    methods: {
        updateRecipe(recipe){
            recipe.accountId = this.account.id;
            recipe.isPublic = recipe.public;
            Object.keys(recipe).forEach(key => {
                if(key != "title" && recipe[key] === this.recipe[key])
                    recipe[key] = null;
            });
            console.log(recipe.title);
            recipe.id = this.recipe.id;
            update(recipe)
            .then(res => {
                if(recipe.imageFile)
                    uploadRecipePicture(recipe.imageFile, recipe.title);
                this.snackbar = true;
            })
            .catch(err => {
                if(err.response){
                    if(err.response.status == 409){
                        this.errors.title.push("Title is already being used");
                    }
                }
                else{
                    console.log("Network Error");
                }
            })
        },
        redirectToLogin(){
            this.$router.push({
                path: "/login",
                query: {
                    redirectPath: "/overview"
                }
            })
        }
    }
}
</script>

<style scoped>
.root{
    padding: 100px 400px;
}
</style>
