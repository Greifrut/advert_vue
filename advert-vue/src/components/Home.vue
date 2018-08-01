<template>
  <div>
    <v-container fluid>
      <v-layout row>
        <v-flex xs12>
          <v-carousel>
            <v-carousel-item></v-carousel-item>
          </v-carousel>
        </v-flex>
      </v-layout>
    </v-container>
    <v-container>

    </v-container>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        ads: [
          {
            title: 'First ads',
            description: 'Description',
            promo: false,
            imageSrc: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg',
            id: '1'
          },
          {
            title: 'Second ads',
            description: 'Description',
            promo: true,
            imageSrc: 'https://cdn.vuetifyjs.com/images/carousel/sky.jpg',
            id: '2'
          },
          {
            title: 'Third ads',
            description: 'Description',
            promo: true,
            imageSrc: 'https://cdn.vuetifyjs.com/images/carousel/bird.jpg',
            id: '3'
          }
        ]
      }
    }
  }
</script>