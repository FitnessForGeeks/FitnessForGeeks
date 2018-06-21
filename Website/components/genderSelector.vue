<template>
    <v-radio-group v-model="selectedRadio" label="Gender" @change="() => $emit('input', isMale)">
        <v-radio label="Male" :value="1"></v-radio>
        <v-radio label="Female" :value="2"></v-radio>
    </v-radio-group>
</template>

<script>
export default {
    props: ["value"],
    data(){
        return {
            isMale: this.value,
            selectedRadio: this.value? 1 : 2,
        }
    },
    watch:{
        selectedRadio(val){
            this.isMale = val == 1;
            this.$emit("input", this.isMale);
        }
    }
}
</script>

<style>

</style>
