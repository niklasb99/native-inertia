<script setup lang="ts">
import { Link } from "@inertiajs/vue3";
import { defineProps } from "vue";

let props = defineProps<{
  time: string;
  id: string;
  color: string;
}>();

let startTime: number;
let stopTime: number;

const stopTimer = () => {
  const storedStartTime = localStorage.getItem("startTime");
  if (storedStartTime) {
    startTime = parseInt(storedStartTime); // In localstorage strings are stored - conversion of the string into a number
    stopTime = Date.now();
    const duration = stopTime - startTime;
    console.log("Starttime:", startTime);
    console.log("Stoptime:", stopTime);
    console.log(`%c Duration: ${duration} ms`, 'color: green');
  }

  localStorage.removeItem("startTime");
};

stopTimer();

</script>

<template>
  <main :style="{ backgroundColor: `#${props.color}` }">
    <Link :href="`/`"><svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 24 24" fill="none"
      stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
      class="feather feather-arrow-left-circle">
      <circle cx="12" cy="12" r="10"></circle>
      <polyline points="12 8 8 12 12 16"></polyline>
      <line x1="16" y1="12" x2="8" y2="12"></line>
    </svg></Link>

    <div class="content--container">
      <h2 class="headline">Page {{ props.id }}</h2>
      <p>Opened at: {{ props.time }}</p>
    </div>
  </main>
</template>

<style scoped>
main {
  padding-top: 20px;
  color: white;
  height: 100vh;
}

.content--container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 200px;
}

.headline {
  font-size: 30px;
  font-weight: 700;
  margin-bottom: 20px;
}

a {
  all: unset;
}
</style>

<style>
body {
  margin: 0;
}
</style>