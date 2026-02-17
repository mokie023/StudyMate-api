import { http } from '../../../lib/http'

export function register(payload) {
  return http('/api/v1/auth/register', {
    method: 'POST',
    body: JSON.stringify(payload),
  })
}

export function login(payload) {
  return http('/api/v1/auth/login', {
    method: 'POST',
    body: JSON.stringify(payload),
  })
}

export function logout() {
  return http('/api/v1/auth/logout', {
    method: 'POST',
  })
}
