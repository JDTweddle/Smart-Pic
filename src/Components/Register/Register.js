import React from 'react';

class Register extends React.Component {
  state = {
    email: '',
    password: '',
    name: '',
  };

  onNameChange = (event) => {
    this.setState({ name: event.target.value });
  };

  onEmailChange = (event) => {
    this.setState({ email: event.target.value });
  };

  onPasswordChange = (event) => {
    this.setState({ password: event.target.value });
  };

  onSubmit = () => {
    const { email, password, name } = this.state;
    fetch(`${process.env.REACT_APP_API_URL}/register`, {
      method: 'post',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: JSON.stringify({ email, password, name }),
    })
      .then((response) => response.json())
      .then((user) => {
        if (user.id) {
          this.props.loadUser(user);
          this.props.onRouteChange('home');
        }
      })
      .catch(console.error);
  };

  render() {
    const { onRouteChange } = this.props;
    return (
      <div className='flex items-center justify-center vh-100'>
        <article className='br3 ba dark-gray b--black-10 mv4 w-100 w-50-m w-25-l mw6 shadow-5 center'>
          <main className='pa4 black-80'>
            <div className='measure'>
              <fieldset id='sign_up' className='ba b--transparent ph0 mh0'>
                <legend className='f2 fw6 ph0 mh0'>Register</legend>
                <div className='mt3'>
                  <label className='db fw6 lh-copy f4' htmlFor='name'>
                    Name
                  </label>
                  <input
                    className='pa2 input-reset ba bg-transparent hover-bg-black hover-white w-100'
                    type='text'
                    id='name'
                    onChange={this.onNameChange}
                  />
                </div>
                <div className='mt3'>
                  <label className='db fw6 lh-copy f4' htmlFor='email-address'>
                    Email
                  </label>
                  <input
                    className='pa2 input-reset ba bg-transparent hover-bg-black hover-white w-100'
                    type='email'
                    id='email-address'
                    onChange={this.onEmailChange}
                  />
                </div>
                <div className='mv3'>
                  <label className='db fw6 lh-copy f4' htmlFor='password'>
                    Password
                  </label>
                  <input
                    className='b pa2 input-reset ba bg-transparent hover-bg-black hover-white w-100'
                    type='password'
                    id='password'
                    onChange={this.onPasswordChange}
                  />
                </div>
              </fieldset>
              <div className=''>
                <input
                  onClick={this.onSubmit}
                  className='b white ph3 pv2 input-reset ba b--black bg-orange grow pointer f5 dib'
                  type='submit'
                  value='Register'
                />
              </div>
              <div className='lh-copy mt3'>
                <p
                  onClick={() => onRouteChange('signin')}
                  className='f5 link black grow pointer db'
                >
                  Sign In
                </p>
              </div>
            </div>
          </main>
        </article>
      </div>
    );
  }
}

export default Register;
