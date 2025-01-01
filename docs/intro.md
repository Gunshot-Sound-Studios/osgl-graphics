---
sidebar_position: 1
---

# Introduction

## About

Welcome! This tutorial will introduce you to the basics of using the **OSGL** (Open-Source-Graphical-Library) API. OSGL provides a high-level abstraction of the EditableImage API, allowing you to interact directly with Roblox's [EditableImage](https://create.roblox.com/docs/reference/engine/classes/EditableImage). This interface simplifies writing to EditableImages, resulting in better performance compared to other graphical frameworks like [CanvasDraw](https://devforum.roblox.com/t/canvasdraw-a-powerful-pixel-based-graphics-library-draw-pixels-lines-triangles-readmodify-image-data-and-much-more/1624633).

OSGL is designed for programmers who seek high performance and flexibility, but this comes with the risk of erroneous code. For example, the ability to directly modify and set a window's buffer, which can lead to errors if not handled carefully. Additionally, OSGL offers tools to assist in development, such as the `image-converter` executable, which can create a [Texture](./Textures/loading-textures.md) from a locally stored image.

Before you start, make sure you have the following prerequisites:
- [Roblox Studio & A Roblox account](https://create.roblox.com)
- [Basic knowledge of Luau](https://luau.org) - *If you're new to Luau, there are plenty of resources available to help you learn.*

This tutorial assumes you have a basic understanding of how to use Roblox Studio and basic knowledge of [Luau](https://luau.org). While prior knowledge of computer graphics concepts is not required, it may be helpful.

You can find various code examples in the `examples` folder of the GitHub repository.

## Tutorial Structure

We'll start by setting up your development environment for OSGL. Once that's ready, we'll create a window for rendering, covering the initialization and configuration of window properties. 

Next, we'll guide you through rendering basic shapes and explain the drawing process in detail. We'll then move on to working with textures, including how to load and display them. 

After that, we'll show you how to load and render video content while managing playback. Finally, we'll explain how OSGL works internally for those who want to change or modify the source code, giving you a clear understanding of its architecture.

By the end of this tutorial, you'll have a solid understanding of how to effectively use OSGL in your projects.

:::note

This tutorial is intended to be a community effort; OSGL is still relatively new, and best practices are still evolving. If you have any feedback on the tutorial or the site itself, please don't hesitate to submit an issue or pull request to the GitHub repository. You can watch the repository to be notified of updates to the tutorial. You can learn more about contribution [here](https://github.com/Gunshot-Sound-Studios/osgl-graphics/blob/main/CONTRIBUTING.md).

:::