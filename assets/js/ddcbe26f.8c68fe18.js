"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[989],{3905:(e,n,t)=>{t.d(n,{Zo:()=>c,kt:()=>m});var r=t(67294);function o(e,n,t){return n in e?Object.defineProperty(e,n,{value:t,enumerable:!0,configurable:!0,writable:!0}):e[n]=t,e}function a(e,n){var t=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);n&&(r=r.filter((function(n){return Object.getOwnPropertyDescriptor(e,n).enumerable}))),t.push.apply(t,r)}return t}function i(e){for(var n=1;n<arguments.length;n++){var t=null!=arguments[n]?arguments[n]:{};n%2?a(Object(t),!0).forEach((function(n){o(e,n,t[n])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(t)):a(Object(t)).forEach((function(n){Object.defineProperty(e,n,Object.getOwnPropertyDescriptor(t,n))}))}return e}function l(e,n){if(null==e)return{};var t,r,o=function(e,n){if(null==e)return{};var t,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||(o[t]=e[t]);return o}(e,n);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)t=a[r],n.indexOf(t)>=0||Object.prototype.propertyIsEnumerable.call(e,t)&&(o[t]=e[t])}return o}var d=r.createContext({}),s=function(e){var n=r.useContext(d),t=n;return e&&(t="function"==typeof e?e(n):i(i({},n),e)),t},c=function(e){var n=s(e.components);return r.createElement(d.Provider,{value:n},e.children)},p="mdxType",w={inlineCode:"code",wrapper:function(e){var n=e.children;return r.createElement(r.Fragment,{},n)}},u=r.forwardRef((function(e,n){var t=e.components,o=e.mdxType,a=e.originalType,d=e.parentName,c=l(e,["components","mdxType","originalType","parentName"]),p=s(t),u=o,m=p["".concat(d,".").concat(u)]||p[u]||w[u]||a;return t?r.createElement(m,i(i({ref:n},c),{},{components:t})):r.createElement(m,i({ref:n},c))}));function m(e,n){var t=arguments,o=n&&n.mdxType;if("string"==typeof e||o){var a=t.length,i=new Array(a);i[0]=u;var l={};for(var d in n)hasOwnProperty.call(n,d)&&(l[d]=n[d]);l.originalType=e,l[p]="string"==typeof e?e:o,i[1]=l;for(var s=2;s<a;s++)i[s]=t[s];return r.createElement.apply(null,i)}return r.createElement.apply(null,t)}u.displayName="MDXCreateElement"},2116:(e,n,t)=>{t.r(n),t.d(n,{assets:()=>d,contentTitle:()=>i,default:()=>w,frontMatter:()=>a,metadata:()=>l,toc:()=>s});var r=t(87462),o=(t(67294),t(3905));const a={sidebar_position:2},i="Managing & Rendering to a window",l={unversionedId:"Windows/managing-and-rendering-to-a-window",id:"Windows/managing-and-rendering-to-a-window",title:"Managing & Rendering to a window",description:"Now that we have our window, let's make this code a bit more interesting:",source:"@site/docs/Windows/managing-and-rendering-to-a-window.md",sourceDirName:"Windows",slug:"/Windows/managing-and-rendering-to-a-window",permalink:"/osgl-graphics/docs/Windows/managing-and-rendering-to-a-window",draft:!1,editUrl:"https://github.com/Gunshot-Sound-Studios/osgl-graphics/edit/main/docs/Windows/managing-and-rendering-to-a-window.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"defaultSidebar",previous:{title:"Opening a window",permalink:"/osgl-graphics/docs/Windows/opening-a-window"},next:{title:"Loading Textures",permalink:"/osgl-graphics/docs/Sprites/loading-textures"}},d={},s=[],c={toc:s},p="wrapper";function w(e){let{components:n,...t}=e;return(0,o.kt)(p,(0,r.Z)({},c,t,{components:n,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"managing--rendering-to-a-window"},"Managing & Rendering to a window"),(0,o.kt)("p",null,"Now that we have our window, let's make this code a bit more interesting:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local OSGL = require(ReplicatedStorage.Packages.OSGL)\nlocal Window = OSGL.Window\nlocal color = OSGL.color\n\nlocal windowUi -- reference to windowUi, our `ImageLabel`\n\n-- Create our window, 500x500\nlocal myWindow = Window.new(windowUi, { sizeX = 500, sizeY = 500 })\n\nwhile myWindow:IsOpen() do\n    myWindow:Clear(color.BLACK)\n    myWindow:Render()\nend\n")),(0,o.kt)("p",null,"In summary, the above code creates a window, and while it is open, clears the screen with a ",(0,o.kt)("inlineCode",{parentName:"p"},"BLACK")," color (0, 0, 0, 255). The ",(0,o.kt)("inlineCode",{parentName:"p"},"IsOpen")," method returns if our window still exists, yielding for a heartbeat, meaning we don't need to include a ",(0,o.kt)("inlineCode",{parentName:"p"},"task.wait"),". The ",(0,o.kt)("inlineCode",{parentName:"p"},"Clear")," method clears the Windows' ",(0,o.kt)("inlineCode",{parentName:"p"},"buffer")," with the given color, which in this case is ",(0,o.kt)("inlineCode",{parentName:"p"},"BLACK"),". Finally, we call the ",(0,o.kt)("inlineCode",{parentName:"p"},"Render")," method, which, as the name suggests, renders the ",(0,o.kt)("inlineCode",{parentName:"p"},"buffer")," to the screen. After the window is destroyed, the program will end. The ",(0,o.kt)("inlineCode",{parentName:"p"},"color")," sub-module is used to manipulate OSGL colors (RGBA format)."),(0,o.kt)("p",null,"Using ",(0,o.kt)("inlineCode",{parentName:"p"},"IsOpen"),' is known as the "event loop" or the "game loop". The contents of this loop are usually executed every frame. But what else can we do other than clear the buffer?'),(0,o.kt)("p",null,"We can utilize the ",(0,o.kt)("inlineCode",{parentName:"p"},"draw")," sub-module to draw directly to the ",(0,o.kt)("inlineCode",{parentName:"p"},"buffer"),". All drawing functions require a Window or Texture to draw to. For example, to draw a pixel:"),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},"local OSGL = require(ReplicatedStorage.Packages.OSGL)\nlocal Window = OSGL.Window\nlocal color = OSGL.color\n\nlocal windowUi = -- *reference to windowUi, our `ImageLabel`*\n\n-- Create our window, 10x10\nlocal myWindow = Window.new(windowUi, { sizeX = 10, sizeY = 10 })\n\nwhile myWindow:IsOpen() do\n    myWindow:Clear(color.BLACK)\n    -- It isn't necessary to clear the screen. If you want to keep the contents\n    -- of the previous frame, you can!\n\n    -- Draw a red pixel on `myWindow`, at 0, 0\n    draw.pixel(myWindow, 0, 0, color.RED)\n\n    myWindow:Render()\nend\n")),(0,o.kt)("p",null,"You can learn more about the different shapes you can draw in ",(0,o.kt)("a",{parentName:"p",href:"../Shapes/drawing-shapes"},"Drawing Shapes")," section!"))}w.isMDXComponent=!0}}]);