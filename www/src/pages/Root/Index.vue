<script setup lang="ts">
import { Link } from "@inertiajs/vue3";

let props = defineProps<{
  timestamps: number;
}>();

let deleteAll = () => {
  console.log("Delete all")
}

let add = () => {
  console.log("Add")

  console.log(props.timestamps)
}
</script>

<template>
  <main>
    <div class="navigation--container">
      <div class="navigation--item">
        <button @click="deleteAll">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
        </button>
      </div>
      <div class="navigation--item">
        <button @click="add">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        </button>
      </div>

    </div>
    <h1 class="unselectable">Timestamps</h1>
    <div class="list--container">

      <div class="list--item">
        <div class="list--item-checkmark">
          <button class="checked">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>
          </button>
        </div>
        <div class="list--item-timestamp unselectable">821673871234876213 ms</div>
      </div>

      <div class="list--item">
        <div class="list--item-checkmark">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>        </div>
        <div class="list--item-timestamp unselectable">821673871234876213 ms</div>
      </div>

      <div class="list--item">
        <div class="list--item-checkmark">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>
        </div>
        <div class="list--item-timestamp unselectable">821673871234876213 ms</div>
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

  justify-content: flex-start;

  gap: 24px;

  align-items: center;
}
</style>
