<script setup lang="ts">
import { router } from '@inertiajs/vue3';
import { watch } from 'vue';

let props = defineProps<{
  degree: number;
}>();

let update = () => {
  location.reload()
}

document.addEventListener("visibilitychange", function () {
  if (document.visibilityState === "visible") {
    router.reload()
    router.get("/");

  }
});
</script>

<template>
  <main>


        <div><button @click="update">UPDATE!</button></div>
      <div>{{ props.degree }}</div>
   
  </main>
</template>

<style>
main {
  font-family: Arial, Helvetica, sans-serif;
  position: relative;
}

body {
  margin: 0;
  background-color: #F2F2F7;
  padding-top: 6px;
  padding-left: 18px;
  padding-right: 18px;
}

button {
  all: unset;
  background-color: rgb(33, 149, 149);
  color: white;
  padding: 100px;
}

</style>