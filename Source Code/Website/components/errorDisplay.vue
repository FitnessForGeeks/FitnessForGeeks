<template>
    <div class="error-container">
        <span class="error-content">
            <slot></slot>
            <v-icon x-large color="red">warning</v-icon>
        </span>
    </div>  
</template>

<script>
export default {
};
</script>

<style scoped>
.error-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
}
.error-content {
	display: inline-block;
	font-weight: bold;
	font-size: 30px;
	margin-top: -20px;
}
</style>
