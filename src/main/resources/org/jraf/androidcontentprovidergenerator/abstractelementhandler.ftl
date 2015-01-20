<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import android.support.annotation.NonNull;

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

public abstract class AbstractElementHandler<MODEL extends BaseModel, CURSOR extends AbstractCursor> implements TypedDatabaseElementHandler<MODEL, CURSOR> {
    @NonNull
    public final DatabaseSerializer<MODEL, CURSOR> serializer;

    protected AbstractElementHandler(@NonNull DatabaseSerializer<MODEL, CURSOR> serializer) {
        this.serializer = serializer;
    }

    @NonNull
    @Override
    public MODEL cursorToItem(@NonNull CURSOR cursor) throws InvalidDbEntry {
        return serializer.getValueFromCursor(cursor);
    }
}
