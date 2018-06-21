<template>
<div class="recipe-direction">
    <div class="index-button-wrapper">
        <v-btn 
            class="index-button" 
            :ripple="false" 
            :color="isCompleted? 'primary': 'grey'" 
            :depressed="isCompleted" 
            :outline="!isCompleted" 
            small
            fab 
            @click="() => $emit('completionChanged')"
        >
            <v-icon v-if="isCompleted" medium>done</v-icon>
            <span v-else class="index-text">{{index + 1}}</span>
        </v-btn>
    </div>
    <span :class="'direction-text ' + (isCompleted? 'completed' : '') ">
        {{direction}}
    </span>
</div>
</template>

<script>
export default {
    props:["isCompleted", "direction", "index"]
}
</script>

<style scoped>
.recipe-direction {
    display: flex;
    width: 100%;
    padding: 5px 0;

}
.index-button-wrapper{
    display: flex;
    height: 100%;
}

.index-button {
    margin-top: -8px;

}

.index-button i {
    margin-top: 10px;
}

.index-text {
    font-size: 20px;
    margin-top: -3px;
    margin-left: 1px;
}
.completed {
    color: rgb(172, 172, 172);
}

.direction-text {
    width: 100%;
    font-size: 17px;
}

</style>
