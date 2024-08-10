import React, { Component } from 'react';
import Particles from './Components/Particles/Particles.js';
import Clarifai from 'clarifai';
import Recognition from './Components/Recognition/Recognition.js';
import './App.css';
import Logo from './Components/Logo/Logo.js';
import ImageLinkForm from './Components/ImageLinkForm/ImageLinkForm.js';

window.process = {};

const initialState = {
  input: '',
  imageUrl: '',
  detections: [],
};

class App extends Component {
  constructor(props) {
    super(props);
    this.state = initialState;
    this.app = new Clarifai.App({
      apiKey: 'eb9dac37032d467f9b5330841b227b91',
    });
  }

  calculateDetectionBoxes = (data) => {
    const regions = data.outputs[0].data.regions;
    const image = document.getElementById('inputimage');
    const width = Number(image.width);
    const height = Number(image.height);

    return regions.map((region) => {
      const clarifaiBox = region.region_info.bounding_box;

      return {
        box: {
          topRow: clarifaiBox.top_row * height,
          rightCol: width - clarifaiBox.right_col * width,
          bottomRow: height - clarifaiBox.bottom_row * height,
          leftCol: clarifaiBox.left_col * width,
        },
        concept: region.data.concepts[0],
      };
    });
  };

  onInputChange = (event) => {
    this.setState({ input: event.target.value });
  };

  onButtonSubmit = () => {
    this.setState({ imageUrl: this.state.input });
    this.app.models
      .predict('general-image-detection', this.state.input)
      .then((response) => {
        const detections = this.calculateDetectionBoxes(response);
        this.setState({ detections });
      })
      .catch((err) => console.log(err));
  };

  onImageUpload = (event) => {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.onload = () => {
      this.setState({ imageUrl: reader.result });
      this.app.models
        .predict('general-image-detection', { base64: reader.result.split(',')[1] })
        .then((response) => {
          const detections = this.calculateDetectionBoxes(response);
          this.setState({ detections });
        })
        .catch((err) => console.log(err));
    };
    reader.readAsDataURL(file);
  };

  render() {
    const { imageUrl, detections } = this.state;
    return (
      <div className="App">
        <Particles />
        <Logo />
        <ImageLinkForm
          onInputChange={this.onInputChange}
          onButtonSubmit={this.onButtonSubmit}
          onImageUpload={this.onImageUpload}
        />
        <Recognition
          boxes={detections.map((d) => d.box)}
          imageUrl={imageUrl}
          concepts={detections.map((d) => d.concept)}
        />
      </div>
    );
  }
}

export default App;


