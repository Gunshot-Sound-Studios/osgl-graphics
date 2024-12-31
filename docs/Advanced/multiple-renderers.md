---
sidebar_position: 2
---

# Multiple Renderers

`Window`s can render to numerous instances simultaneously with minimal to no performance degradation. This capability is facilitated by the efficient management of renderers through the `AddRenderer` and `RemoveRenderer` methods. These methods enable addition and removal of renderers from the `Window` during runtime.

## Adding a Renderer

To add a renderer to a `Window`, utilize the `AddRenderer` method. This method accepts a variadic list of Images as arguments and appends them to the `Window`'s renderer list. This allows the `Window` to render multiple images concurrently.

```lua
window:AddRenderer(imageOne, imageTwo)
```

## Removing a Renderer

Conversely, to remove a renderer from a `Window`, use the `RemoveRenderer` method. This method also accepts a variadic list of Images as arguments. If the specified Images are currently being rendered by the `Window`, they will be removed from the renderer list:

```lua
window:RemoveRenderer(imageOne)
```