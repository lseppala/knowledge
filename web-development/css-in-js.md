# CSS-in-JS

## `styled-components`

One of the most popular CSS-in-JS frameworks, typically used along with React
and other Single Page App (SPA) libraries:

Example:

```javascript
const Button = styled.a`
  display: inline-block;
  border-radius: 3px;
  padding: 0.5rem 0;
  margin: 0.5rem 1rem;
  width: 11rem;
  background: transparent;
  color: white;
  border: 2px solid white;

  /* The GitHub button is a primary button
   * edit this to target it specifically! */
  ${(props) =>
    props.primary &&
    css`
      background: white;
      color: palevioletred;
    `}
`;

render(
  <div>
    <Button
      href="https://github.com/styled-components/styled-components"
      target="_blank"
      rel="noopener"
      primary
    >
      GitHub
    </Button>

    <Button as={Link} href="/docs">
      Documentation
    </Button>
  </div>
);
```

styled-componentes exports a function `styled` that uses
[Tagged template literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals).
You define the CSS styling for an element within the literal and
styled-components will render an element-specific CSS with the style applied via
class identifier (this helps with performance in rendering).

### Supporting libraries

- Plugin for CoC: https://github.com/fannheyward/coc-styled-components
- TypeScript 'transformer' that provides compile-time errors with
  styled-components:
  https://github.com/Igorbek/typescript-plugin-styled-components
- Jest utiltities for testing stlyes:
  https://github.com/styled-components/jest-styled-components

## CSS Modules

CSS modules provides a way to write a .css file and then import it into your
JavaScript or TypeScript file. https://github.com/css-modules/css-modules

The generated class names help avoid styling collision:

```javascript

/* Thumbnail.css */
.image {
  border-radius: 3px;
}

/* Thumbnail.jsx */
import styles from './Thumbnail.css';
render() { return (<img className={styles.image}/>) }

/* Rendered DOM */
<img class="Thumbnail__image___1DA66"/>

/* Processed Thumbnail.css */
.Thumbnail__image___1DA66 {
  border-radius: 3px;
}
```
