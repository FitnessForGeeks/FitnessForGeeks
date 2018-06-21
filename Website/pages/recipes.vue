<template>
    <div :class="'recipe-page' + classDependingOnMini ">
        <div class="recipe-wrapper">
            <div>
                <search-sidebar 
                    :loading="loadingRecipes" 
                    :items="recipes"
                    @search="onSearchRequest" 
                    @new-index="newRecipeIndex"
                    @mini-toggle="onMiniToggle"
                >
                </search-sidebar>
            </div>
            <dir v-if="!loadingRecipes && recipes.length != 0">
                <recipe
                    v-if="!loadingRecipes"
                    ref="recipe"
                    :recipe="selectedRecipe"
                    @eat="snackbar = true"
                ></recipe>
                <v-snackbar
                    bottom
                    left
                    v-model="snackbar"
                    v-if="!loadingRecipes"
                >
                    You have eaten {{selectedRecipe.calories}} Calories
                    <v-btn flat color="primary" @click.native="snackbar = false">Close</v-btn>
                </v-snackbar>
            </dir>
        </div>
    </div>
</template>

<script>
import { getAll as getAllRecipes } from "@/assets/recipe";
import { mapGetters } from "vuex";
import axios from "axios";
import Recipe from "@/components/recipes/recipe.vue";
import SearchSidebar from "@/components/searchSidebar";

export default {
    components: {
        SearchSidebar,
        Recipe
    },
    computed: {
        ...mapGetters({
            account: "account/account"
        }),
        selectedRecipe() {
            return this.recipes[this.recipeIndex];
        },
        classDependingOnMini(){
            return this.isMini? " mini " : "";
        }
    },
    mounted(){
        this.loadRecipes();
    },
    data() {
        return {
            recipes: [],
            reviews: [],
            recipeIndex: 0,
            isMini: false,
            snackbar: false,
            loadingRecipes: true
        };
    },
    methods: {
        loadRecipes(){
            getAllRecipes({
                pageNumber: 1,
                isAscending: false,
                sortText: "rating"
            })
            .then(res => {
                this.loadingRecipes = false;
                this.recipes = res.data;
                this.$nextTick(() => {
                    if(this.$refs.recipe && this.account && this.recipes.length != 0)
                        this.$refs.recipe.loadReviews(this.selectedRecipe.id);
                });
            })
            .catch(err => console.log(err));
        },
        newRecipeIndex(i) {
            this.recipeIndex = i;
            window.scrollTo(0, 0);
            this.$nextTick(() => {
                    this.$refs.recipe.loadReviews(this.recipes[this.recipeIndex].id);
            });
        },
        onSearchRequest(data) {
            this.loadingRecipes = true;
            getAllRecipes(data)
            .then(res => {
                console.log(res);
                this.loadingRecipes = false;
                this.recipes = res.data;
            });
        },
        onMiniToggle(isMini){
            this.isMini = isMini;
        }
    }
};
</script>

<style scoped>

.infoWrapper {
    padding: 10px;
    width: 100%;
    height: 100%;
}
.recipe-page {
    height: 100%;
    margin-left: 400px;
}

.recipe-page.mini {
    margin-left: 80px;
}
</style>
