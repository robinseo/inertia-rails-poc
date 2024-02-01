<template>
  <div class="flash flash-success" v-if="flash.success">
    <p>{{ flash.success }}</p>
    <button class="close-btn" @click="flash.success = null">X</button>
  </div>
  <div class="flash flash-warning" v-if="flash.alert">
    <p>{{ flash.alert }}</p>
    <button class="close-btn" @click="flash.alert = null">X</button>
  </div>
</template>

<script setup>
import { getCurrentInstance, ref, watchEffect } from "vue"

const { proxy } = getCurrentInstance()
const flash = ref({
  success: proxy.$page.props.flash.success,
  alert: proxy.$page.props.flash.alert
})

watchEffect(() => {
  flash.value = {
    success: proxy.$page.props.flash.success,
    alert: proxy.$page.props.flash.alert
  }
})
</script>

<style scoped lang="scss">
.flash {
  width: calc(70vw - 2rem);
  padding: 0 1rem;
  border: 1px solid;
  border-radius: .5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;

  &-success {
    border-color: #05f105;
    background: #0bb00b;
    color: white;
  }

  &-warning {
    border-color: #8c1414;
    background: darkred;
    color: white;

  }

  .close-btn {
    background: transparent;
    border: none;
    color: white;
    font-weight: bolder;
    font-size: 1rem;
    cursor: pointer;
  }
}

</style>