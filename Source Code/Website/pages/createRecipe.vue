<template>
    <div class="root">
        <recipe-form
            submit-value="Create"
            :errors="errors"
            @submit="createRecipe"
        ></recipe-form>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
import RecipeForm from "@/components/recipeForm.vue";
import { create, uploadRecipePicture } from "@/assets/recipe";

export default {
    computed:{
        ...mapGetters({
            account: "account/account",
            authenticating: "account/authenticating",
        })
    },
    data(){
        return {
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
        createRecipe(recipe){
            recipe.accountId = this.account.id;
            recipe.isPublic = recipe.public;
            create(recipe)
            .then(res => {
                uploadRecipePicture(recipe.imageFile, recipe.title);
                this.$router.push("/myRecipes")
            })
            .catch(error => {
                if(error.response){
                    if(error.response.status === 409){
                        this.errors.title.push("This title is already being used");
                    }
                }
                else
                    console.log("network error")
            });
        }
    }
}
</script>

<style scoped>
.root{
    padding: 100px 400px;
}
</style>
