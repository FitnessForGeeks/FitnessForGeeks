<template>
    <v-btn color="primary" :disabled="disabled" v-on="this.$listeners"> 
        <v-progress-circular v-if="loading" size="25" indeterminate></v-progress-circular>
        <span v-else>
            <slot></slot>
        </span>
    </v-btn>   
</template>

<script>
export default {
    mounted(){
    },
    props: [ "loading", "disabled"],
}
</script>

<style scoped>

</style>
