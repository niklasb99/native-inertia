<script setup lang="ts">
import { router } from '@inertiajs/vue3';

let props = defineProps<{
  timestamps: Array<[boolean, number]>;
}>();

let deleteAll = () => {
  router.delete(`/timestamps/delete-all`)
}

let trash = (id: any) => {
  router.delete(`/timestamps/delete/${id}`)
  getData()
}

let add = () => {
  router.delete(`/timestamps/add`)
  getData()
}

let update = (id: any) => {
  router.delete(`/timestamps/update/${id}`)
  getData()
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

let getData = () => {
  window.location.reload()
}

document.addEventListener("visibilitychange", function() {
  if (document.visibilityState === "visible") {
    window.location.reload()  }
});

</script>

<template>
  <main>

    <!-- Navigation -->
    <div class="navigation--container">
      <div class="navigation--item">
        <button @click="deleteAll">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2"> <polyline points="3 6 5 6 21 6"></polyline> <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path> <line x1="10" y1="11" x2="10" y2="17"></line> <line x1="14" y1="11" x2="14" y2="17"></line> </svg>
        </button>
      </div>

      <div class="navigation--item">
        <button @click="getData()"> Get Data </button>
      </div>

      <!-- <div class="navigation--item">
        <button @click="editData()">Edit</button>
      </div> -->

      <div class="navigation--item">
        <button @click="add">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus"> <line x1="12" y1="5" x2="12" y2="19"></line> <line x1="5" y1="12" x2="19" y2="12"></line> </svg>
        </button>
      </div>

    </div>

    <!-- Headline -->
    <h1 class="unselectable">Timestamps</h1>

    <!-- List -->
    <div class="list--container">

      <div class="list--item" v-for="timestamp in props.timestamps">

        <div><button v-html="validate(timestamp[0])" @click="update(timestamp[1])"></button></div>
        <div>{{ timestamp[1] }} ms</div>
        <button @click="trash(timestamp[1])" class="delete-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2"> <polyline points="3 6 5 6 21 6"></polyline> <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path> <line x1="10" y1="11" x2="10" y2="17"></line> <line x1="14" y1="11" x2="14" y2="17"></line> </svg>
        </button>

      </div>

    </div>

  </main>
</template>




<style>
main {
  font-family: Arial, Helvetica, sans-serif
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
  all: unset
}

.navigation--container {
  display: flex;
  justify-content: space-between;
}

.list--container {
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

/* .delete-icon {
  visibility: hidden;
} */
</style>
