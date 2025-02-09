"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[996],{64243:(e,r,t)=>{t.r(r),t.d(r,{assets:()=>l,contentTitle:()=>s,default:()=>x,frontMatter:()=>i,metadata:()=>n,toc:()=>d});const n=JSON.parse('{"id":"Textures/rendering-textures","title":"Rendering Textures","description":"Drawing a Texture on Another Texture","source":"@site/docs/Textures/rendering-textures.md","sourceDirName":"Textures","slug":"/Textures/rendering-textures","permalink":"/osgl/docs/Textures/rendering-textures","draft":false,"unlisted":false,"editUrl":"https://github.com/osgl-rbx/osgl/edit/main/docs/Textures/rendering-textures.md","tags":[],"version":"current","sidebarPosition":2,"frontMatter":{"sidebar_position":2},"sidebar":"defaultSidebar","previous":{"title":"Loading Textures","permalink":"/osgl/docs/Textures/loading-textures"},"next":{"title":"Custom OSGL Image Format","permalink":"/osgl/docs/Textures/custom-texture-format"}}');var a=t(74848),o=t(28453);const i={sidebar_position:2},s="Rendering Textures",l={},d=[{value:"Drawing a Texture on Another Texture",id:"drawing-a-texture-on-another-texture",level:2},{value:"Explanation",id:"explanation",level:3},{value:"Drawing a Texture onto a Window",id:"drawing-a-texture-onto-a-window",level:2},{value:"Example: Combining Textures with Layers",id:"example-combining-textures-with-layers",level:2}];function u(e){const r={code:"code",h1:"h1",h2:"h2",h3:"h3",header:"header",li:"li",p:"p",pre:"pre",ul:"ul",...(0,o.R)(),...e.components};return(0,a.jsxs)(a.Fragment,{children:[(0,a.jsx)(r.header,{children:(0,a.jsx)(r.h1,{id:"rendering-textures",children:"Rendering Textures"})}),"\n",(0,a.jsx)(r.h2,{id:"drawing-a-texture-on-another-texture",children:"Drawing a Texture on Another Texture"}),"\n",(0,a.jsxs)(r.p,{children:["In OSGL, a ",(0,a.jsx)(r.code,{children:"Texture"})," is essentially a buffer, similar to a ",(0,a.jsx)(r.code,{children:"Window"}),". To render a ",(0,a.jsx)(r.code,{children:"Texture"})," onto another ",(0,a.jsx)(r.code,{children:"DrawableObject"}),", such as a ",(0,a.jsx)(r.code,{children:"Window"})," or another ",(0,a.jsx)(r.code,{children:"Texture"}),", use the ",(0,a.jsx)(r.code,{children:"Texture.draw"})," function:"]}),"\n",(0,a.jsx)(r.pre,{children:(0,a.jsx)(r.code,{className:"language-lua",children:"local OSGL = require(path.to.osgl)\r\nlocal Texture = OSGL.Texture\r\n\r\nlocal textureData = require(path.to.texture)\r\nlocal secondTextureData = require(path.to.secondTexture)\r\n\r\nlocal textureA = Texture.from(textureData)\r\nlocal textureB = Texture.from(secondTextureData)\r\n\r\n-- Draw textureB on textureA at (0, 0)\r\nlocal textureC = Texture.draw(textureA, textureB, 0, 0)\n"})}),"\n",(0,a.jsx)(r.h3,{id:"explanation",children:"Explanation"}),"\n",(0,a.jsxs)(r.ul,{children:["\n",(0,a.jsxs)(r.li,{children:["Two textures, ",(0,a.jsx)(r.code,{children:"textureA"})," and ",(0,a.jsx)(r.code,{children:"textureB"}),", are loaded using the ",(0,a.jsx)(r.code,{children:"Texture.from"})," function."]}),"\n",(0,a.jsxs)(r.li,{children:["The ",(0,a.jsx)(r.code,{children:"Texture.draw"})," function draws ",(0,a.jsx)(r.code,{children:"textureB"})," onto ",(0,a.jsx)(r.code,{children:"textureA"})," at position (0, 0). This operation returns a new ",(0,a.jsx)(r.code,{children:"Texture"})," object, assigned to ",(0,a.jsx)(r.code,{children:"textureC"}),"."]}),"\n"]}),"\n",(0,a.jsx)(r.h2,{id:"drawing-a-texture-onto-a-window",children:"Drawing a Texture onto a Window"}),"\n",(0,a.jsxs)(r.p,{children:["You can also draw a ",(0,a.jsx)(r.code,{children:"Texture"})," onto a ",(0,a.jsx)(r.code,{children:"Window"}),", as it is a ",(0,a.jsx)(r.code,{children:"DrawableObject"}),":"]}),"\n",(0,a.jsx)(r.pre,{children:(0,a.jsx)(r.code,{className:"language-lua",children:"local OSGL = require(path.to.osgl)\r\nlocal Window = OSGL.Window\r\nlocal Texture = OSGL.Texture\r\n\r\n-- Create a new window\r\nlocal myWindow = Window.new(parent, { sizeX = 100, sizeY = 100 })\r\n\r\n-- Load a texture\r\nlocal textureData = require(path.to.texture)\r\nlocal myTexture = Texture.from(textureData)\r\n\r\n-- Draw the texture onto the window at position (10, 10)\r\nTexture.draw(myWindow, myTexture, 10, 10)\r\n\r\n-- Render the window to display it on the screen\r\nmyWindow:Render()\n"})}),"\n",(0,a.jsx)(r.h2,{id:"example-combining-textures-with-layers",children:"Example: Combining Textures with Layers"}),"\n",(0,a.jsxs)(r.p,{children:["Using this knowledge, you can layer multiple ",(0,a.jsx)(r.code,{children:"Texture"})," objects onto a single ",(0,a.jsx)(r.code,{children:"DrawableObject"}),":"]}),"\n",(0,a.jsx)(r.pre,{children:(0,a.jsx)(r.code,{className:"language-lua",children:"local OSGL = require(path.to.osgl)\r\nlocal Texture = OSGL.Texture\r\n\r\n-- Load base texture and two additional layers\r\nlocal baseTextureData = require(path.to.baseTexture)\r\nlocal layer1Data = require(path.to.layer1)\r\nlocal layer2Data = require(path.to.layer2)\r\n\r\nlocal baseTexture = Texture.from(baseTextureData)\r\nlocal layer1 = Texture.from(layer1Data)\r\nlocal layer2 = Texture.from(layer2Data)\r\n\r\n-- Draw layer1 onto the base texture at (20, 20)\r\nTexture.draw(baseTexture, layer1, 20, 20)\r\n\r\n-- Draw layer2 onto the updated base texture at (40, 40)\r\nTexture.draw(baseTexture, layer2, 40, 40)\r\n\r\n-- Now baseTexture contains both layers combined!\n"})})]})}function x(e={}){const{wrapper:r}={...(0,o.R)(),...e.components};return r?(0,a.jsx)(r,{...e,children:(0,a.jsx)(u,{...e})}):u(e)}},28453:(e,r,t)=>{t.d(r,{R:()=>i,x:()=>s});var n=t(96540);const a={},o=n.createContext(a);function i(e){const r=n.useContext(o);return n.useMemo((function(){return"function"==typeof e?e(r):{...r,...e}}),[r,e])}function s(e){let r;return r=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:i(e.components),n.createElement(o.Provider,{value:r},e.children)}}}]);