<template>
  <Head title="Contacts"/>
  <Flash/>

  <h1>Contacts</h1>
  <div class="list-head">
    <Link :href="$routes.new_contact()" as="button">Create New Contact</Link>
  </div>
  <table>
    <th>Name</th>
    <th>Phone</th>
    <th>Actions</th>
    <tr v-for="contact in contacts" :key="contact.id" v-if="contacts.length > 0">
      <td>{{ `${contact.first_name} ${contact.last_name}` }}</td>
      <td>
        <div v-for="cn in contact.contact_numbers" :key="`${contact.id}-${cn.number}`">
          {{ `[${cn.label}] ${cn.number}` }}
        </div>
      </td>
      <td class="actions">
        <Link as="button" :href="$routes.edit_contact(contact.id)">Edit</Link>
        <Link as="button"
              :href="$routes.contact(contact.id)"
              method="delete">
          Delete
        </Link>
      </td>
    </tr>
    <tr v-else>
      <td colspan="3">No Contacts Yet.</td>
    </tr>
  </table>

</template>

<script setup>
import {Head, Link} from "@inertiajs/vue3"
import Flash from "@/components/Flash.vue"

defineProps(
    {contacts: Array}
)
</script>

<style scoped lang="scss">
button {
  padding: .725rem 1rem;
}

.list-head {
  width: 70vw;
  display: flex;
  justify-content: flex-end;
  margin-bottom: 1rem;
}

table {
  width: 70vw;
  border-collapse: collapse;
  border: 1px solid black;

  th, tr, td {
    border: 1px solid black;
  }

  th {
    background-color: #ccc;
    padding: 1rem 3rem;
  }

  td {
    padding: 0.725rem 1rem;
  }

  .actions {
    text-align: center;

    & > :not(:last-child) {
      margin-right: .5rem;
    }
  }
}
</style>