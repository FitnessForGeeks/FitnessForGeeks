<template>
    <div class="root">
        <dropdown-menu
            :items="sortMenuItems"
            @click="onDropdownItemClicked"
        >
        </dropdown-menu>
        <ul class="recipe-reviews">
            <li v-for="(review, i) in reviews" :key="i">
                <recipe-review
                    :review="review"
                >
                </recipe-review>
            </li>
        </ul>
        <div class="paginator-container">
            <v-pagination
                :length="paginationLength"
                v-model="currentPage"
                ref="paginator"
                class="paginator"
                @input="onNextPage"
            ></v-pagination>
        </div>
    </div>
</template>

<script>
import RecipeReview from "./recipeReview.vue";
import DropdownMenu from "@/components/dropdownMenu.vue";

export default {
    components: {
        RecipeReview,
        DropdownMenu
    },
    data(){
        return {
            currentPage: 1,
            selectedSort: {
                index: 0,
                isAscending: true
            },
            sortMenuItems: ["newest", "rating"],
            isNewRecipe: false
        }
    },
    computed: {
        paginationLength(){
            const length = this.recipe.reviewCount / 5;
            const decimals = length % 1;
            const output = Math.round(decimals === 0? length : length + 1 - decimals);
            return output;
        }
    },
    watch: {
        reviews(newVal, oldVal){
            if(oldVal.length !== 0 && !this.isNewRecipe){
                this.$nextTick(() => window.scrollTo(0, document.body.scrollHeight));
            }

            if(this.isNewRecipe)
                this.isNewRecipe = false;
        }
    },
    methods:{
        onDropdownItemClicked({ itemIndex, isAscending }){
            this.selectedSort = {
                index: itemIndex,
                isAscending
            };
            this.onNextPage();
        },
        onNextPage(){
            this.$emit("load-page", this.currentPage, {
                text: this.sortMenuItems[this.selectedSort.index],
                isAscending : this.selectedSort.isAscending
            });
        },
        onNewRecipe(){
            this.isNewRecipe = true;
        }
    },
    props: ["reviews", "recipe"]
}
</script>

<style scoped>

.sort-menu-item-icon{
    margin-left: auto;
}

.sort-btn-icon{
    margin-right: 10px;
}

.root{
    padding: 0 100px;
    padding-bottom: 50px;
}

.recipe-reviews {
    margin-bottom: 50px;
}

.recipe-reviews li{
    list-style-type: none;
}

.paginator-container{
    display: flex;
}

.paginator{
    margin: 0 auto;
}

</style>
