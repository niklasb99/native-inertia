<script setup lang="ts">
import { Link } from "@inertiajs/vue3";

const backgroundColor1 = "007AFE"
const backgroundColor2 = "35C759"
const backgroundColor3 = "FF9500"

const startTimer = () => {
  let startTime = Date.now();
  localStorage.setItem("startTime", String(startTime));
};

let setBackgroundColor = () => {
  let main = document.getElementsByTagName("body")[0];
  main.style.backgroundColor = "white"
}

setBackgroundColor();
</script>

<template>
  <main>
    <p class="headline">Requirement 1</p>
    <p class="subheadline">Routing</p>
    <div class="button--container">
      <Link :href="'/1'" :style="{ backgroundColor: `#${backgroundColor1}` }" @click="startTimer">Page 1</Link>
      <Link :href="'/2'" :style="{ backgroundColor: `#${backgroundColor2}` }" @click="startTimer">Page 2</Link>
      <Link :href="'/3'" :style="{ backgroundColor: `#${backgroundColor3}` }" @click="startTimer">Page 3</Link>
    </div>
  </main>
</template>

<style scoped>
main {
  padding-top: 120px;
  text-align: center;
}

.headline {
  font-size: 27px;
  margin: 0;
}

.subheadline {
  font-size: 27px;
  font-weight: 700;
  margin: 0;
}

.button--container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 136px;
}

a {
  all: unset;
  border-radius: 4px;
  color: white;
  margin-bottom: 36px;
  padding: 16px 15px;
  font-size: 16px;
}
</style>