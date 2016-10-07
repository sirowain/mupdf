#import "MuAnnotation.h"

@implementation MuAnnotation
{
	int type;
	CGRect rect;
	char* fieldName;
}

@synthesize type, rect, fieldName;

-(instancetype) initFromAnnot:(fz_annot *)annot inDoc:(pdf_document*)doc;
{
	self = [super init];
	if (self)
	{
		fz_rect frect;
		type = pdf_annot_type(ctx, (pdf_annot *)annot);
		fz_bound_annot(ctx, annot, &frect);
		rect.origin.x = frect.x0;
		rect.origin.y = frect.y0;
		rect.size.width = frect.x1 - frect.x0;
		rect.size.height = frect.y1 - frect.y0;
		
		// fieldname
		pdf_annot *pdf_annot = pdf_annot_from_fz_annot(ctx, annot);
		fieldName = pdf_field_name(ctx, doc, pdf_annot->obj);
	}
	return self;
}

+(MuAnnotation *) annotFromAnnot:(fz_annot *)annot inDoc:(pdf_document*)doc;
{
	return [[[MuAnnotation alloc] initFromAnnot:annot inDoc:doc] autorelease];
}
@end
