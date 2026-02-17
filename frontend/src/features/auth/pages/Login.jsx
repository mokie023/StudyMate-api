export default function Login() {
  return (
    <section className="page">
      <div className="card auth-card">
        <h2>Welcome Back</h2>
        <p className="muted">Sign in to continue managing your classes and goals.</p>
        <form className="form-grid">
          <label>
            Email
            <input className="input" type="email" placeholder="you@example.com" />
          </label>
          <label>
            Password
            <input className="input" type="password" placeholder="••••••••" />
          </label>
          <button className="btn btn-primary" type="button">Sign In</button>
        </form>
      </div>
    </section>
  )
}
