<template>
    <div class="root" v-if="account">
        <div class="left">
            <v-avatar :size="70">
                <img :src="account.profilePicture"/>
            </v-avatar>
            <span class="username">{{account.username}}</span>
        </div>
        <div class="right">
            <star-rating
                :show-rating="false" 
                :increment="0.5"
                :star-size="25"
                v-model="rating"
            ></star-rating>
            <v-text-field
                auto-grow
                multi-line
                placeholder="Write a review..."
                rows="1"
                v-model="text"
            >
            </v-text-field>
            <div v-show="text !== ''" class="post-button-container">
                <v-btn
                    flat
                    @click="ClearPostForm"
                >cancel</v-btn>
                <v-btn
                    color="primary"
                    @click="OnPostReview"
                >post</v-btn>
            </div>
        </div>
    </div>
</template>

<script>
import { mapGetters } from "vuex";
import StarRating from "vue-star-rating";

export default {
    components:{
        StarRating
    },
    computed: {
        ...mapGetters({
            account: "account/account"
        })
    },
    data(){
        return {
            rating: 0.0,
            text: ""
        }
    },
    methods:{
        OnPostReview(event){
            this.$emit("post-request", { 
                rating: this.rating,
                text: this.text
            });
            this.ClearPostForm();
        },
        ClearPostForm(){
            this.rating = 0.0;
            this.text = "";
        }
    }
}
</script>

<style scoped>
.root{
    display: flex;
    padding: 0 100px;
    margin-bottom: 0px;
}

.left{
    display: flex;
    flex-direction: column;
    padding-right: 10px;
}

.right{
    display: flex;
    width: 100%;
    flex-direction: column;
}

.username{
    text-align: center;
}

.text{
    background-color: #FAFAFA;
}

.post-button-container{
    display: flex;
    justify-content: flex-end;
}

</style>
