<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.source.typed.TypedDatabaseElementHandler;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

public abstract class AbstractElementHandler<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> implements TypedDatabaseElementHandler<MODEL, CURSOR> {
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

    protected abstract SELECTION getItemSelection(@NonNull MODEL itemToSelect);

    @NonNull
    @Override
    public String getItemSelectClause(@Nullable MODEL itemToSelect) {
        if (itemToSelect != null) {
            return getItemSelection(itemToSelect).sel();
        }
        return "";
    }

    @NonNull
    @Override
    public String[] getItemSelectArgs(@NonNull MODEL itemToSelect) {
        return getItemSelection(itemToSelect).args();
    }
}
