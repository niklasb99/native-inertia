<script setup lang="ts">
import { router } from "@inertiajs/vue3";

let props = defineProps<{
  degree: number
}>();

function handleVisibilityChange() {
  if (!document.hidden) {
    setInterval(function () {
      router.get("/");
    }, 500);
  }
}

document.addEventListener("visibilitychange", handleVisibilityChange);

</script>

<template>
  <header></header>

  <main>
    <div>{{ -1 * (props.degree) }}</div>

    <div class="fixpunkt-top"></div>

    <div class="compass1">
      <img src="../../assets/compass-g0c7a5e191_1280.png" id="compass" :style="`transform: rotate(${props.degree}deg)`">
    </div>
  </main>
</template>

<style scoped>
main {
  display: flex;
  justify-content: center;
}

.fixpunkt-top {
  border: 3px solid black;
  height: 40px;
  width: 0;

  position: absolute;
  top: 80px;
}

.compass1 {
  border: 5px;
  border-color: black;
  border-style: dotted;
  height: 250px;
  width: 250px;
  border-radius: 50%;

  position: absolute;
  top: 150px;

  display: flex;
  justify-content: center;
  align-items: center;
}

img {
  height: 225px;
  width: 225px;
  transition: transform 0.3s ease-in-out;
}
</style>