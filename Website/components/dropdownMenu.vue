<template>
    <v-menu offset-y>
        <v-btn 
            flat 
            small
            slot="activator"
            class="sort-btn"
        > 
            <v-icon class="dropdown-icon">sort</v-icon>sort by
        </v-btn>
        <v-list dense>
            <div v-for="(item, i) in uppercaseItems" :key="i">
                <v-list-tile  @click="onDropdownClick(i, true)">
                    {{item}} <v-icon small class="dropdown-item-icon">arrow_upwards</v-icon>
                </v-list-tile>
                <v-list-tile  @click="onDropdownClick(i, false)">
                    {{item}} <v-icon small class="dropdown-item-icon">arrow_downwards</v-icon>
                </v-list-tile>
            </div>
        </v-list>
    </v-menu>   
</template>

<script>
export default {
    props: ["items"],
    methods:{
        onDropdownClick(i, isAscending){
            this.$emit("click", {
                itemIndex: i,
                isAscending
            })
        }
    },
    computed: {
        uppercaseItems(){
            return this.items.map(item => item.toUpperCase());
        }
    }
}
</script>

<style scoped>
.dropdown-item-icon{
    margin-left: auto;
    width: 14px;
}
.dropdown-icon{
    margin-right: 10px;
}
</style>
