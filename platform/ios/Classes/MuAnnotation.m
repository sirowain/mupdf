#import "MuAnnotation.h"

@implementation MuAnnotation
{
	int type;
	int widgetType;
	char *fieldName;
	int fieldFlags;
	CGRect rect;
}

@synthesize type, widgetType, fieldName, fieldFlags, rect;

-(id) initFromAnnot:(fz_annot *)annot;
{
	self = [super init];
	if (self)
	{
		fz_rect frect;
		type = pdf_annot_type(ctx, (pdf_annot *)annot);
		widgetType = pdf_widget_get_type(ctx, (pdf_widget *)annot);
		fz_bound_annot(ctx, annot, &frect);
		rect.origin.x = frect.x0;
		rect.origin.y = frect.y0;
		rect.size.width = frect.x1 - frect.x0;
		rect.size.height = frect.y1 - frect.y0;
		
		// fieldname
		pdf_document *doc = pdf_get_indirect_document(ctx, ((pdf_annot*)annot)->obj);
		fieldName = pdf_field_name(ctx, doc, ((pdf_annot*)annot)->obj);
		
		// flags
		fieldFlags = pdf_get_field_flags(ctx, doc, ((pdf_annot*)annot)->obj);
	}
	return self;
}

+(MuAnnotation *) annotFromAnnot:(fz_annot *)annot;
{
	return [[[MuAnnotation alloc] initFromAnnot:annot] autorelease];
}

- (BOOL)isReadOnly
{
	return (fieldFlags & Ff_ReadOnly);
}

- (BOOL)isRequired
{
	return (fieldFlags & Ff_Required);
}

@end
