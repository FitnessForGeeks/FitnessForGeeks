<template>
    <v-navigation-drawer permanent :fixed="true" :class="'sidebar' + classDependingOnMini" :mini-variant="mini" >
        <div :class="'search-form' + classDependingOnMini">
            <v-text-field
                solo
                flat
                autofocus
                @keydown.native.enter="() => onSearch()"
                v-model="query"
                :class="'search-field' + classDependingOnMini"
                placeholder = "Search"
            >
            </v-text-field>
            <v-btn
                :class="'search-button' + classDependingOnMini"
                depressed
                color="primary"
                @click="onSearch"
            ><v-icon>search</v-icon></v-btn>
            <v-icon large :class="'toggle-button' + classDependingOnMini" @click="onToggleMini">{{toggleButtonArrow}}</v-icon>
        </div>
        <dropdown-menu
            :items="dropdownMenuItems"
            @click="onDropdownItemClicked"
            v-if="!mini"
        ></dropdown-menu>
        <v-list v-if="!loading" dense class="result-list">
            <v-list-tile v-for="(item, i) in items" :key="i" :color="selectedIndex === i? 'primary' : ''" @click="() => changeIndex(i)">
                <v-list-tile-avatar>
                    <img :src="item.image" alt="" srcset="">
                </v-list-tile-avatar>
                <v-list-tile-content>
                    <v-list-tile-title>
                        {{ item.title }}
                    </v-list-tile-title>
                    <v-list-tile-sub-title>
                        {{ item.subTitle}}
                    </v-list-tile-sub-title>
                </v-list-tile-content>
            </v-list-tile>
        </v-list>
        <v-progress-circular v-else indeterminate class="loading-circle"></v-progress-circular>
        <div class="paginator-container" v-if="false">
            <v-pagination
                class="paginator"
                :length="6"
                v-model="currentPage"
                @input="onSearch"
            ></v-pagination>
        </div>
    </v-navigation-drawer>
</template>

<script>
import DropdownMenu from "./dropdownMenu.vue";

export default {
    props: ["loading", "items"],
    components:{
        DropdownMenu
    },
    data(){
        return {
            query: "",
            mini: false,
            dropdownMenuItems: ["rating"],
            selectedIndex: 0,
            currentPage: 1
        }
    },
    computed: {
        toggleButtonArrow(){
            return this.mini? "arrow_right" : "arrow_left";
        },
        classDependingOnMini(){
            return this.mini? " mini " : "";
        }
    },
    methods:{
        onDropdownItemClicked(payload){
            const { itemIndex, isAscending } = payload;
            this.$emit("search", {
                pageNumber: this.currentPage,
                sortText: this.dropdownMenuItems[itemIndex],
                query: this.query,
                isAscending
            });
        },
        onSearch(){
            this.$emit("search", {
                pageNumber: this.currentPage,
                sortText: this.dropdownMenuItems[0],
                query: this.query,
                isAscending: true
            });
        },
        changeIndex(i){
            this.$emit("new-index", i);
            this.selectedIndex = i;
        },
        onToggleMini(){
            this.mini = !this.mini;
            this.$emit("mini-toggle", this.mini);
        }
    }
}
</script>

<style scoped>
.dropdown{
    margin-left: auto;
}
.result-list{
    height: 100%;
}
.search-form{
    display: flex;
    width: 100%;
    border-bottom: 1px solid lightgray;
    margin-bottom: 3px;
    padding-bottom: 3px;
}
.sidebar{
    display: flex;
    flex-direction: column;
    flex-grow: inherit;
    min-width: 400px;
    margin-top: 68px !important;
    padding-bottom: 80px !important;
}

.sidebar.mini{
    min-width: 0;
}

.search-button.mini,
.search-field.mini{
    display: none;
}

.search-form.mini{
    padding-bottom: 10px;
}

.loading-circle{
    display: block;
    padding-top: 100px;
    height: 100%;
    margin: 0 auto;
}

.toggle-button{
    margin-top: 5px;
    margin-right: 5px;
    cursor: pointer;
}

.toggle-button.mini{
    margin-left: auto;
    margin-right: auto;
}

.paginator-container{
    display: flex;
}

.paginator{
    margin: 0 auto;
}

</style>
