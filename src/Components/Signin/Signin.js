import React from 'react';

class Signin extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      signInEmail: '',
      signInPassword: ''
    }
  }

  onEmailChange = (event) => {
    this.setState({ signInEmail: event.target.value });
  };

  onPasswordChange = (event) => {
    this.setState({ signInPassword: event.target.value });
  };

  onSubmit = () => {
    const { signInEmail, signInPassword } = this.state;
    fetch(`${process.env.REACT_APP_API_URL}/signin`, {
      method: 'post',
      headers: { 'Content-Type': 'application/json; charset=utf-8' },
      body: JSON.stringify({ email: signInEmail, password: signInPassword }),
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
                <legend className='f2 fw6 ph0 mh0'>Sign In</legend>
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
                  value='Sign in'
                />
              </div>
              <div className='lh-copy mt3'>
                <p
                  onClick={() => onRouteChange('register')}
                  className='f5 link black grow pointer db'
                >
                  Register
                </p>
              </div>
            </div>
          </main>
        </article>
      </div>
    );
  }
}

export default Signin;
