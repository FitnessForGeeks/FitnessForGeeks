<template>
<div class="directions-root">
    <h1 class="directions-title">Directions</h1>
    <v-list class="list">
        <recipe-direction 
            v-for="(direction, i) in directions" 
            :key="i"
            :direction="direction"
            :isCompleted="completedDirections[i]"
            :index="i"
            @completionChanged="() => $set(completedDirections, i, !completedDirections[i])"
        >
        </recipe-direction>
    </v-list>
</div>
</template>

<script>
import RecipeDirection from "./recipeDirection.vue";

export default {
    props: ["directions"],
    components:{
        RecipeDirection
    },
    data(){
        return {
            completedDirections: []
        }
    }
}
</script>

<style scoped>

.directions-root {
    display: flex;
    flex-direction: column;
    padding-top: 100px;
    padding-left: 13.3%;
    padding-right: 200px;
}

.directions-title{
    text-align: center;
    margin-right: 30px;
    margin-bottom: 30px;
}


</style>
