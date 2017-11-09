#include "common.h"
#include "mupdf/pdf.h"
#import <Foundation/Foundation.h>

@interface MuAnnotation : NSObject

-(id) initFromAnnot:(fz_annot *)annot;
-(BOOL)isReadOnly;
-(BOOL)isRequired;

@property(readonly) int type;
@property(readonly) int widgetType;
@property(readonly) char *fieldName;
@property(readonly) int fieldFlags;
@property(readonly) CGRect rect;

+(MuAnnotation *) annotFromAnnot:(fz_annot *)annot;

@end
