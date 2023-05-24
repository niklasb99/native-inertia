<script setup lang="ts">
import { router } from '@inertiajs/vue3';

let props = defineProps<{
  timestamps: Array<[boolean, number]>;
}>();

let startTime = 0;
let stopTime = 0;

window.addEventListener('native-inertia', function(event) {
  let stopTime = Date.now()
  let erg = stopTime - startTime;
  console.log('Change', erg);
});

let deleteAllTimestamps = () => {
  router.delete(`/timestamps/`, { preserveScroll: true })
  startTime = Date.now()
}

let deleteTimestamp = (id: any) => {
  router.delete(`/timestamps/${id}`, { preserveScroll: true })
  startTime = Date.now()
}

let addTimestamp = () => {
  router.post(`/timestamps/`, {}, { preserveScroll: true })
  startTime = Date.now()
  props.timestamps.push([true, 12345]); // Beispielhafte Änderung an 'timestamps'

}

let updateTimestamp = (id: any) => {
  router.patch(`/timestamps/${id}`, {}, { preserveScroll: true })
  startTime = Date.now()
}

let validate = (bool: Boolean) => {
  let result = '';

  if (bool == true) {
    result = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"> <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path> <polyline points="22 4 12 14.01 9 11.01"></polyline> </svg>`
  } else {
    result = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>`
  }
  return result;
}



document.addEventListener("visibilitychange", function() {
  if (document.visibilityState === "visible") {
  router.reload({ preserveScroll: true })
  }
});
</script>

<template>
  <main>

    <!-- Navigation -->
    <div class="navigation--container">
      <div class="navigation--item">
        <button @click="deleteAllTimestamps">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2"> <polyline points="3 6 5 6 21 6"></polyline> <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path> <line x1="10" y1="11" x2="10" y2="17"></line> <line x1="14" y1="11" x2="14" y2="17"></line> </svg>
        </button>
      </div>

      <div class="navigation--item">
        <button @click="addTimestamp">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus"> <line x1="12" y1="5" x2="12" y2="19"></line> <line x1="5" y1="12" x2="19" y2="12"></line> </svg>
        </button>
      </div>

    </div>


    <!-- List -->
    <div class="list--container">

    <h1 class="unselectable">Timestamps</h1>

      <div class=".unselectable list--item" v-for="timestamp in props.timestamps">

        <div><button v-html="validate(timestamp[0])" @click="updateTimestamp(timestamp[1])"></button></div>
        <div>{{ timestamp[1] }} ms</div>
        <button @click="deleteTimestamp(timestamp[1])" class="delete-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2"> <polyline points="3 6 5 6 21 6"></polyline> <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path> <line x1="10" y1="11" x2="10" y2="17"></line> <line x1="14" y1="11" x2="14" y2="17"></line> </svg>
        </button>

      </div>

    </div>

  </main>
</template>

<script lang="ts">

</script>

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

.unselectable {
  -webkit-touch-callout: none;
  -webkit-user-select: none;
  -khtml-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

h1 {
  margin-top: 6px;
  margin-bottom: 6px;
}

button {
  all: unset;
}

button:focus {
  all: unset;
}

.navigation--container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  display: flex;
  justify-content: space-between;
  background-color: #F2F2F7;
}

.navigation--item {
  padding: 12px;
}

.list--container {
  margin-top: 40px;
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.list--item {
  background-color: white;
  padding: 10px;
  border-radius: 4px;

  display: flex;

  gap: 12px;
  font-size: 18px;

  justify-content: space-between;

  gap: 24px;

  align-items: center;
}
</style>
