<template>
    <div class="root">
        <v-card height="100%">
            <v-card-title>
                <h1>
                    Recipes
                </h1>
                
                <v-btn
                    color="primary"
                    class="add-button"
                    depressed
                    @click="onAddRecipe"
                >
                    <v-icon style="margin-right: 5px" >add_circle</v-icon>
                    add
                </v-btn>
            </v-card-title>
            <v-card-media>
                <div class="loading-circle-container" v-if="loading">
                    <v-progress-circular indeterminate class="loading-circle"></v-progress-circular>
                </div>
                <v-list v-else class="recipe-list">
                    <v-list-tile v-for="(recipe, i) in recipes" :key="i" class="recipe" >
                        <v-list-tile-content class="recipe-content">
                            <h2>{{recipe.title}}</h2>
                        </v-list-tile-content>
                        <span class="review-count">{{recipe.reviewCount}} Reviews</span>
                        <star-rating
                            read-only
                            class="rating"
                            :star-size="20"
                            :show-rating="false"
                            v-model="recipe.avgRating"
                        ></star-rating>
                        <v-list-tile-avatar>
                            <img :src="recipe.image" >
                        </v-list-tile-avatar>
                        <v-list-tile-action>
                            <v-btn small fab icon color="primary" @click="onEditRecipe(i)"><v-icon style="margin-top: 20px">edit</v-icon></v-btn>
                        </v-list-tile-action>
                        <v-list-tile-action>
                            <v-btn small fab icon color="red" @click="onDeleteRecipe(i)"><v-icon style="margin-top: 20px;color: white">remove_circle</v-icon></v-btn>
                        </v-list-tile-action>
                    </v-list-tile>
                </v-list>
            </v-card-media>
        </v-card>
        <v-dialog v-model="dialog" persistent max-width="500">
            <v-card>
                <v-card-title class="headline">Delete '{{currentDeleteRecipeTitle}}'?</v-card-title>
                <v-card-text>Once the recipe is deleted, it can not be recovered</v-card-text>
                <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="green darken-1" flat @click.native="onCancelDialog">Cancel</v-btn>
                <v-btn color="green darken-1" flat @click.native="onContinueDialog">Continue</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
import { getMyRecipes } from "@/assets/account";
import { deleteRecipe } from "@/assets/recipe";
import StarRating from "vue-star-rating";

export default {
    computed:{
        ...mapGetters({
            account: "account/account",
            authenticating: "account/authenticating"
        }),
        currentDeleteRecipeTitle(){
            if(!this.recipes[this.indexToDelete]){
                return "";
            }
            return this.recipes[this.indexToDelete].title;
        }
    },
    data(){
        return {
            recipes: [],
            loading: false,
            dialog: false,
            indexToDelete: 0
        };
    },
    components: {
        StarRating
    },
    watch: {
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
                    this.loadRecipes();
                }
            }
        }
    },
    mounted(){
        if(this.account)
            this.loadRecipes();
    },
    methods:{
        onCancelDialog(){
            this.dialog = false;
        },
        onContinueDialog(){
            this.dialog = false;
            deleteRecipe(this.recipes[this.indexToDelete].id)
            .then(res => {
                this.recipes.splice(this.indexToDelete, 1);
            });
        },
        loadRecipes(){
            this.loading = true;
            getMyRecipes(this.account.id)
            .then(res => {
                this.loading = false;
                this.recipes = res.data;
                console.log(this.recipes);
            });
        },
        onAddRecipe(){
            this.$router.push("/createRecipe");
        },
        onEditRecipe(i){
            this.$router.push({
                name: "editRecipe",
                params: {
                    recipe: JSON.stringify(this.recipes[i])
                }
            })
        },
        onDeleteRecipe(i){
            this.indexToDelete = i;
            this.dialog = true;
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
.loading-circle-container{
    width: 100%;
    display: flex;
}
.loading-circle{
    margin: 0 auto;
}
.add-button{
    margin-left: auto;
}
.review-count{
    margin-right: 10px;
}
.root{
    display: flex;
    flex-direction: column;
    height: 100%;
    padding: 100px 200px;
}
.card{
    height: 100vh;
    padding: 20px;
}
.recipe-list{
    width: 50%;
    margin: 0 auto;
    height: 100%;
}
.recipe-list li{
    list-style-type: none;
}
</style>
