<template>
  <Head title="Edit Contact"/>
  <h1>Edit Contact</h1>
  <form class="new-contact-form" @submit.prevent="createContact">
    <section class="form-section">
      <input type="text" placeholder="first_name" v-model="form.first_name" autofocus>
      <FormErrorMessage :error="form.errors" error-key="first_name"/>
      <input type="text" placeholder="last_name" v-model="form.last_name">
      <FormErrorMessage :error="form.errors" error-key="last_name"/>
    </section>
    <section class="form-section">
      <div class="inline-phone-number" v-for="(contact_number, index) in form.contact_numbers_attributes" :key="index">
        <div class="remove-btn" @click="() => removeContactNumber(index)">-</div>
        <select v-model="contact_number.label">
          <option v-for="label in contact_number_labels" :key="label" :value="label">{{ label }}</option>
        </select>
        <input type="text"
               placeholder="number"
               v-model="contact_number.number"
               oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
      </div>
      <FormErrorMessage :error="form.errors" error-key="contact_numbers.number"/>
      <button type="button" @click="addContactNumber">+ Add Phone Number</button>
    </section>
    <section class="form-section">
      <button type="submit" :disabled="form.processing">Update Contact</button>
    </section>
    <Link :href="$routes.contacts()">Back To List</Link>
  </form>
</template>

<script setup>
import {Head, useForm, Link} from "@inertiajs/vue3"
import {getCurrentInstance} from "vue"
import FormErrorMessage from "@/components/FormErrorMessage.vue"

const {proxy} = getCurrentInstance()

const props = defineProps({
  contact_number_labels: {type: Array},
  contact: {type: Object}
})

const form = useForm({
  first_name: props.contact.first_name,
  last_name: props.contact.last_name,
  company: props.contact.company,
  contact_numbers_attributes: props.contact.contact_numbers.map(({label, number}) => ({label, number})),
})

const addContactNumber = () => {
  const defaultLabel = props.contact_number_labels[0]
  const existLabels = form.contact_numbers_attributes.map(({label}) => label)
  const availableLabels = props.contact_number_labels.filter(label => !existLabels.includes(label))
  const label = availableLabels[0] ?? defaultLabel
  form.contact_numbers_attributes.push({label, number: null})
}
const removeContactNumber = (index) => form.contact_numbers_attributes.splice(index, 1)
const createContact = () => form.patch(proxy.$routes.contact(props.contact.id))
</script>

<style scoped lang="scss">
.new-contact-form {
  width: 70vw;

  input, button, select {
    padding: .725rem 1rem;
  }

  button {
    cursor: pointer;
  }

  display: flex;
  flex-direction: column;
  gap: 2rem;

  .form-section {
    display: flex;
    flex-direction: column;

    .inline-phone-number {
      display: flex;
      align-items: center;

      .remove-btn {
        width: 1.5rem;
        height: 1.5rem;
        margin: .5rem;
        background-color: red;
        text-align: center;
        color: white;
        cursor: pointer;
        flex-grow: 0;
        display: flex;
        align-items: center;
        border-radius: 100%;
        justify-content: center;
        line-height: 1;
        font-size: 1.25rem;
        font-weight: bolder;
      }

      select {
        flex-grow: 1;
      }

      input {
        flex-grow: 2;
      }
    }
  }
}

</style>