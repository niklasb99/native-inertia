<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { router } from '@inertiajs/vue3';

let props = defineProps<{
  gps?: {
    longitude: number;
    latitude: number;
  };
}>();


const intervalRef = ref<number | undefined>(undefined);

onMounted(() => {
  intervalRef.value = setInterval(() => {
    router.get('/');
  }, 1000);
});

onUnmounted(() => clearInterval(intervalRef.value));

console.log("LONGITUDE: ", props.gps?.longitude)
console.log("LATITUDE: ", props.gps?.latitude)

</script>

<template>
  <header></header>

  <main>
    <h1>GPS</h1>
    <p>Longitude: {{ props.gps?.longitude }} </p>
    <p>Latitude: {{ props.gps?.latitude }} </p>

  </main>
</template>

<style scoped>
main {
  font-family: Arial, Helvetica, sans-serif;
}
</style>


<!-- <script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { router } from '@inertiajs/vue3';
import * as Vue2Leaflet from 'vue2-leaflet';

let props = defineProps<{
  gps?: {
    longitude: number;
    latitude: number;
  };
}>();


const intervalRef = ref<number | undefined>(undefined);

onMounted(() => {
  intervalRef.value = setInterval(() => {
    router.get('/');
  }, 1000);
});

onUnmounted(() => clearInterval(intervalRef.value));

console.log("LONGITUDE: ", props.gps?.longitude)
console.log("LATITUDE: ", props.gps?.latitude)

</script>

<template>
  <header></header>

  <main>
    <h1>GPS</h1>
    <p>Longitude: {{ props.gps?.longitude }} </p>
    <p>Latitude: {{ props.gps?.latitude }} </p>

  </main>
</template>

<style scoped>
main {
  font-family: Arial, Helvetica, sans-serif;
}
</style> -->