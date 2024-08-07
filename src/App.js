import React, { Component } from 'react';
import Particles from './Components/Particles/Particles.js';
import Clarifai from 'clarifai';
import Recognition from './Components/Recognition/Recognition.js';
import './App.css';
import Navigation from './Components/Navigation/Navigation.js';
import Signin from './Components/Signin/Signin.js';
import Register from './Components/Register/Register.js';
import Logo from './Components/Logo/Logo.js';
import ImageLinkForm from './Components/ImageLinkForm/ImageLinkForm.js';
import Rank from './Components/Rank/Rank.js';

window.process = {};

const initialState = {
  input: '',
  imageUrl: '',
  box: {},
  route: 'signin',
  isSignedIn: false,
  user: {
    id: '',
    name: '',
    email: '',
    entries: 0,
    joined: ''
  }
};

class App extends Component {
  constructor() {
    super();
    this.state = initialState;
    this.app = new Clarifai.App({
      apiKey: process.env.REACT_APP_CLARIFAI_API_KEY // Use environment variable
    });
  }

  loadUser = (data) => {
    this.setState({user: {
      id: data.id,
      name: data.name,
      email: data.email,
      entries: data.entries,
      joined: data.joined
    }});
  }

  calculateDetectionBoxes = (data) => {
    const regions = data.outputs[0].data.regions;
    const image = document.getElementById('inputimage');
    const width = Number(image.width);
    const height = Number(image.height);

    const boxes = regions.map((region) => {
      const clarifaiBox = region.region_info.bounding_box;

      return {
        leftCol: clarifaiBox.left_col * width,
        topRow: clarifaiBox.top_row * height,
        rightCol: width - (clarifaiBox.right_col * width),
        bottomRow: height - (clarifaiBox.bottom_row * height)
      };
    });

    return boxes;
  };

  extractConcepts = (data) => {
    const regions = data.outputs[0].data.regions;
    const concepts = regions.map((region) => {
      return region.data.concepts;
    });
    return concepts;
  };

  displayData = (boxes, concepts) => {
    console.log('Boxes:', boxes);
    console.log('Concepts:', concepts);
    this.setState({ boxes, concepts });
  };

  onInputChange = (event) => {
    this.setState({ input: event.target.value });
  };

  onButtonSubmit = () => {
    this.setState({ imageUrl: this.state.input });
    this.app.models
      .predict('general-image-detection', this.state.input)
      .then((response) => {
        if (response) {
          fetch(`${process.env.REACT_APP_API_URL}/api/imageurl`, {
            method: 'post',
            headers: {'Content-Type': 'application/json; charset=utf-8'},
            body: JSON.stringify({
              input: this.state.input
            })
          })
          .then((response) => response.json())
          .then((data) => {
            if (data) {
              fetch(`${process.env.REACT_APP_API_URL}/api/image`, {
                method: 'put',
                headers: {'Content-Type': 'application/json; charset=utf-8'},
                body: JSON.stringify({
                  id: this.state.user.id
                })
              })
              .then((response) => response.json())
              .then((count) => {
                this.setState(Object.assign(this.state.user, {entries: count}));
              })
              .catch((err) => console.log(err));
            }
            const boxes = this.calculateDetectionBoxes(response);
            const concepts = this.extractConcepts(response);
            this.displayData(boxes, concepts);
          })
          .catch((err) => console.log(err));
        }
      })
      .catch((err) => console.log(err));
  };

  onRouteChange = (route) => {
    if (route === 'signout') {
      this.setState(initialState);
    } else if (route === 'home') {
      this.setState({ isSignedIn: true });
    }
    this.setState({ route: route });
  }

  render() {
    const { isSignedIn, imageUrl, route, boxes, concepts } = this.state;
    let view;
    
    if (route === 'home') {
      view = (
        <div>
          <Logo />
          <Rank
            name={this.state.user.name}
            entries={this.state.user.entries}
          />
          <ImageLinkForm
            onInputChange={this.onInputChange}
            onButtonSubmit={this.onButtonSubmit}
          />
          <Recognition 
            boxes={boxes} 
            imageUrl={imageUrl} 
            concepts={concepts} 
          />
        </div>
      );
    } else if (route === 'signin') {
      view = (
        <Signin 
          loadUser={this.loadUser} 
          onRouteChange={this.onRouteChange}
        />
      );
    } else if (route === 'register') {
      view = (
        <Register 
          loadUser={this.loadUser} 
          onRouteChange={this.onRouteChange}
        />
      );
    }

    return (
      <div className='App'>
        <Particles />
        <Navigation 
          isSignedIn={isSignedIn} 
          onRouteChange={this.onRouteChange} 
        />
        {view}
      </div>
    );
  }
}

export default App;


