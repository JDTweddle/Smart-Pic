import React, { useState } from 'react';
import { signUp, confirmSignUp, signIn, resendConfirmationCode } from '../../cognito.js';
import './AuthPage.css';

const AuthPage = ({ onSignIn }) => {
  const [isSignUp, setIsSignUp] = useState(true);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmationCode, setConfirmationCode] = useState('');
  const [isConfirming, setIsConfirming] = useState(false);
  const [error, setError] = useState('');

  const handleSignUp = async (e) => {
    e.preventDefault();
    setError('');
    try {
      await signUp(email, password);
      setIsConfirming(true);
    } catch (error) {
      setError(error.message);
    }
  };

  const handleConfirmSignUp = async (e) => {
    e.preventDefault();
    setError('');
    try {
      await confirmSignUp(email, confirmationCode);
      setIsConfirming(false);
      setIsSignUp(false);
    } catch (error) {
      setError(error.message);
    }
  };

  const handleSignIn = async (e) => {
    e.preventDefault();
    setError('');
    try {
      await signIn(email, password);
      onSignIn();
    } catch (error) {
      if (error.code === 'UserNotConfirmedException') {
        setError('Please confirm your account first.');
        setIsConfirming(true);
      } else {
        setError(error.message);
      }
    }
  };

  const handleResendCode = async () => {
    setError('');
    try {
      await resendConfirmationCode(email);
      setError('A new confirmation code has been sent to your email.');
    } catch (error) {
      setError(error.message);
    }
  };

  if (isConfirming) {
    return (
      <div className="auth-container">
        <h2>Confirm Sign Up</h2>
        <form onSubmit={handleConfirmSignUp}>
          <input
            type="text"
            value={confirmationCode}
            onChange={(e) => setConfirmationCode(e.target.value)}
            placeholder="Confirmation Code"
            required
          />
          <button type="submit">Confirm Sign Up</button>
        </form>
        <button onClick={handleResendCode}>Resend Code</button>
        {error && <p className="error">{error}</p>}
      </div>
    );
  }

  return (
    <div className="auth-container">
      <div className="auth-box">
        {isConfirming ? (
          <>
            <h2>Confirm Sign Up</h2>
            <form onSubmit={handleConfirmSignUp}>
              <input
                type="text"
                value={confirmationCode}
                onChange={(e) => setConfirmationCode(e.target.value)}
                placeholder="Confirmation Code"
                required
              />
              <button type="submit">Confirm Sign Up</button>
            </form>
            <button className="resend-code" onClick={handleResendCode}>Resend Code</button>
          </>
        ) : (
          <>
            <h2>{isSignUp ? 'Sign Up' : 'Sign In'}</h2>
            <form onSubmit={isSignUp ? handleSignUp : handleSignIn}>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Email"
                required
              />
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Password"
                required
              />
              <button type="submit">{isSignUp ? 'Sign Up' : 'Sign In'}</button>
            </form>
            <p>
              {isSignUp ? 'Already have an account? ' : "Don't have an account? "}
              <button className="switch-auth" onClick={() => setIsSignUp(!isSignUp)}>
                {isSignUp ? 'Sign In' : 'Sign Up'}
              </button>
            </p>
          </>
        )}
        {error && <p className="error">{error}</p>}
      </div>
    </div>
  );
};

export default AuthPage;