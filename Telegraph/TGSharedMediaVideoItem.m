#import "TGSharedMediaVideoItem.h"

#import "TGSharedMediaDirectionFilter.h"

@interface TGSharedMediaVideoItem ()
{
    TGMessage *_message;
    int32_t _messageId;
    NSTimeInterval _date;
    bool _incoming;
}

@end

@implementation TGSharedMediaVideoItem

- (instancetype)initWithMessage:(TGMessage *)message messageId:(int32_t)messageId date:(NSTimeInterval)date incoming:(bool)incoming videoMediaAttachment:(TGVideoMediaAttachment *)videoMediaAttachment
{
    self = [super init];
    if (self != nil)
    {
        _message = message;
        _messageId = messageId;
        _date = date;
        _incoming = incoming;
        _videoMediaAttachment = videoMediaAttachment;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)__unused zone
{
    return [[TGSharedMediaVideoItem alloc] initWithMessage:_message messageId:_messageId date:_date incoming:_incoming videoMediaAttachment:_videoMediaAttachment];
}

- (BOOL)isEqual:(id)object
{
    return [object isKindOfClass:[TGSharedMediaVideoItem class]] && ((TGSharedMediaVideoItem *)object)->_messageId == _messageId;
}

- (NSUInteger)hash
{
    return _messageId;
}

- (TGMessage *)message
{
    return _message;
}

- (int32_t)messageId
{
    return _messageId;
}

- (NSTimeInterval)date
{
    return _date;
}

- (bool)passesFilter:(id<TGSharedMediaFilter>)filter
{
    if ([filter isKindOfClass:[TGSharedMediaDirectionFilter class]])
    {
        switch (((TGSharedMediaDirectionFilter *)filter).direction)
        {
            case TGSharedMediaDirectionBoth:
                return true;
            case TGSharedMediaDirectionIncoming:
                return _incoming;
            case TGSharedMediaDirectionOutgoing:
                return !_incoming;
        }
    }
    return false;
}

@end
