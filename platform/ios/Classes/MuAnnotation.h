#include "common.h"
#include "mupdf/pdf.h"
#import <Foundation/Foundation.h>

@interface MuAnnotation : NSObject
-(instancetype) initFromAnnot:(fz_annot *)annot inDoc:(pdf_document*)doc;
@property(readonly) int type;
@property(readonly) CGRect rect;
@property(readonly) char* fieldName;
+(MuAnnotation *) annotFromAnnot:(fz_annot *)annot inDoc:(pdf_document*)doc;
@end
