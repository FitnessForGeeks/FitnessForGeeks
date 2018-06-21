<template>
    <div>
        <v-icon>remove</v-icon>
        <span class="text">{{text}}</span>
    </div>
</template>

<script>
export default {
    props: ["text"]
}
</script>

<style scoped>

.text {
  font-size: 17px;
}

</style>
