export type PixelStorageBuilder<P> = {
    new: (sizeX: number, sizeY: number) -> PixelStorage<P>,
}

export type PixelStorage<P> = {
    Render: (self: PixelStorage<P>, image: EditableImage, size: Vector2) -> (),
    Clear: (self: PixelStorage<P>, clearColor: P) -> (),
    Resize: (
        self: PixelStorage<P>,
        oldWidth: number,
        oldHeight: number,
        newWidth: number,
        newHeight: number
    ) -> (),
    ReadPixel: (self: PixelStorage<P>, x: number, y: number, sizeX: number) -> P,
    ReadIndex: (self: PixelStorage<P>, i: number) -> P,
    WritePixel: (self: PixelStorage<P>, x: number, y: number, sizeX: number, newColor: P) -> (),
    WriteIndex: (self: PixelStorage<P>, i: number, newColor: P) -> (),
    GetIndex: (self: PixelStorage<P>, x: number, y: number, sizeX: number) -> number,
    OffsetIndex: (self: PixelStorage<P>, i: number, x: number, y: number, sizeX: number) -> number,
}

return nil
