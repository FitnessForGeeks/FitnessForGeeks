<template>
    <div class="root">
        <h1 class="x-title">Ingredients</h1>
        <div class="content">
            <ul class="list">
                <li v-for="(ingredient, i) in ingredients" :key="i">
                    <recipe-ingredient
                        :text="ingredient"
                    ></recipe-ingredient>
                </li>
            </ul>
        </div>
    </div>   
</template>

<script>
import RecipeIngredient from "./recipeIngredient.vue"

export default {
    components:{
        RecipeIngredient
    },
    props: ["ingredients"]
}
</script>

<style scoped>
.root {
  padding-top: 100px;
}
.content {
  width: 100%;
  height: 100%;
}

.list {
  list-style-type: none;
  padding-left: 13.3%;
}

.x-title{
  text-align: center;
  margin-bottom: 20px;
}

</style>
