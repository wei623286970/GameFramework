#ifndef PE2D_PE2D_H
#define PE2D_PE2D_H
#include "render/Direct2DAllocator.h"
#include <memory>


class PhysicsEngine
{
public:
    void RenderByType(CComPtr<ID2D1RenderTarget> rt, CRect bounds);
    void Render(CComPtr<ID2D1RenderTarget> rt, CRect bounds);

    void Initialize(std::shared_ptr<Direct2DRenderTarget> rt);
    void Finalize(std::shared_ptr<Direct2DRenderTarget> rt);
    void Reset(std::shared_ptr<Direct2DRenderTarget> oldRenderTarget, std::shared_ptr<Direct2DRenderTarget> newRenderTarget);

    void SetType(cint value);

private:
    void RenderDefault(CComPtr<ID2D1RenderTarget> rt, CRect bounds);
    void RenderSimpleColor(CComPtr<ID2D1RenderTarget> rt, CRect bounds);
    void RenderSimpleSphere(CComPtr<ID2D1RenderTarget> rt, CRect bounds);
    void RenderMaterialSphere(CComPtr<ID2D1RenderTarget> rt, CRect bounds);

private:
    static void RenderSphereIntern(BYTE* buffer, BYTE* buffer2, cint width, cint height);;
    static void RenderMaterialIntern(BYTE* buffer, int i, int h);

private:
    CComPtr<ID2D1SolidColorBrush> bg;
    CColor bgColor;
    cint type{ 0 };
    std::weak_ptr<Direct2DRenderTarget> d2drt;
    bool painted{ false };
    CComPtr<ID2D1Bitmap> bitmap;
    CComPtr<ID2D1Bitmap> bitmap2;
};

#endif