<template>
    <v-form v-model="valid" class="form">
        <v-text-field 
            autofocus
            class="title"
            label="Title"
            v-model="title"
            :rules="[val => (val != '' || 'Title is required')]"
            :error-messages="errorMessagesTitle"
            required
        ></v-text-field>
        <img :src="image" alt="Image" width="560" height="315" class="image">
        <input type="file" class="image-button" @change="onImageSelected">
        <v-text-field 
            class="description"
            label="Description"
            textarea
            v-model="description"
        ></v-text-field>
        <v-text-field 
            class="calories"
            label="Calories"
            type="number"
            v-model="calories"
        ></v-text-field>
        <div class="list-title">
            <h2>Ingredients</h2>
            <v-btn 
                small 
                depressed
                color="primary"
                class="add-button"
                @click="addIngredient"
            >
                <v-icon style="margin-right: 5px">add_circle</v-icon>
                <h3>add</h3>
            </v-btn>
        </div>
        <v-list class="ingredient-list">
            <v-list-tile v-for="(ingredient, i) in ingredients" :key="i">
                <v-text-field
                    v-model="ingredients[i]"
                ></v-text-field>
                <v-icon
                    color="red"
                    style="cursor: pointer"
                    @click="deleteIngredient(i)"
                >
                    clear
                </v-icon>
            </v-list-tile>
        </v-list>
        <div class="list-title">
            <h2>Directions</h2>
            <v-btn 
                small 
                depressed
                color="primary"
                class="add-button"
                @click="addDirection"
            >
                <v-icon style="margin-right: 5px">add_circle</v-icon>
                <h3>add</h3>
            </v-btn>
        </div>
        <v-list class="direction-list">
            <v-list-tile v-for="(direction, i) in directions" :key="i">
                <v-text-field
                    v-model="directions[i]"
                ></v-text-field>
                <v-icon
                    color="red"
                    style="cursor: pointer"
                    @click="deleteDirection(i)"
                >
                    clear
                </v-icon>
            </v-list-tile>
        </v-list>
        <div class="actions">
            <div class="privacy-select-container">
                <v-select
                    :items="privacyOptions"
                    v-model="privacy"
                    label="Privacy"
                    class="privacy-select"
                ></v-select>
            </div>
            <v-btn
                class="create-button"
                color="primary"
                @click="onCreateRecipe"
            >{{submitValue}}</v-btn>
        </div>
    </v-form>
</template>

<script>
export default {
    props: ["submit-value", "errors", "recipe"],
    data(){
        const defaultData = {
            title: "",
            image: "http://localhost:5000/api/static/recipes/defaultRecipe",
            valid: false,
            imageFile: null,
            privacy: "",
            public: false,
            description: "",
            privacyOptions: [
                "public",
                "private"
            ],
            ingredients:[],
            directions:[],
            calories: 0
        };
        const data = Object.assign(defaultData, this.recipe);
        data.privacy = data.public? "public" : "private";
        return data;
    },
    watch: {
        privacy(val){
            this.public = val === "public";
        }
    },
    computed:{
        errorMessagesTitle(){
            return this.errors? this.errors.title : [];
        },
    },
    methods:{
        onImageSelected(event){
            const file = event.target.files[0];
            const fr = new FileReader();
            this.imageFile = file;
            fr.onload = event => this.image = fr.result;
            fr.readAsDataURL(file);
        },
        addIngredient(){
            this.ingredients.push("");
        },
        addDirection(){
            this.directions.push("");
        },
        deleteIngredient(i){
            const temp = this.ingredients;
            temp.splice(i, 1);
            this.ingredients = temp;
        },
        deleteDirection(i){
            const temp = this.directions;
            temp.splice(i, 1);
            this.directions = temp;
        },
        onCreateRecipe(){
            if(this.errors)
                Object.keys(this.errors).forEach(key => this.errors[key] = []);
            if(this.valid){
                this.$emit("submit", {
                    title: this.title,
                    imageFile: this.imageFile,
                    public: this.public,
                    description: this.description,
                    ingredients: this.ingredients,
                    directions: this.directions,
                    calories: this.calories
                });
            }
        }
    }
}
</script>

<style scoped>
.list-title{
    display: flex;
    align-items: center;
}
.ingredient-list,
.direction-list{
    margin-bottom: 20px;
}
.image{
    margin: 0 auto;
}
.add-button{
    margin-left: auto;
}
.image-button{
    margin-right: auto;
}
.form{
    display: flex;
    flex-direction: column;
}
.actions{
    display: flex;
}
.privacy-select{
    margin-right: auto;
}
.create-button{
    margin-left: auto;
    align-self: center;
}
.privacy-select-container{
    width: 100px;
}
</style>
