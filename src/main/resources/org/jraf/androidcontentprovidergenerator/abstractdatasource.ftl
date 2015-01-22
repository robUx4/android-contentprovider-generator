<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.base;

import org.gawst.asyncdb.source.typed.TypedContentProviderDataSource;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.net.Uri;
import android.provider.BaseColumns;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

public abstract class AbstractDataSource<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> extends TypedContentProviderDataSource<MODEL, CURSOR> {
    @NonNull
    private final AbstractElementHandler<MODEL, CURSOR, SELECTION> databaseElementHandler;

    public AbstractDataSource(@NonNull ContentResolver contentResolver, @NonNull Uri contentProviderUri, @NonNull AbstractElementHandler<MODEL, CURSOR, SELECTION> databaseElementHandler) {
        super(contentResolver, contentProviderUri, databaseElementHandler);
        this.databaseElementHandler = databaseElementHandler;
    }

    public AbstractDataSource(@NonNull Context context, @NonNull Uri contentProviderUri, @NonNull AbstractElementHandler<MODEL, CURSOR, SELECTION> databaseElementHandler) {
        super(context, contentProviderUri, databaseElementHandler);
        this.databaseElementHandler = databaseElementHandler;
    }

    public Uri insert(MODEL model) {
        ContentValues values = databaseElementHandler.serializer.getContentValuesFromData(model, false);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return insert(values);
    }

    public boolean update(MODEL model) {
        ContentValues values = databaseElementHandler.serializer.getContentValuesFromData(model, true);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return update(model, values);
    }

    public CURSOR query(@Nullable String[] columns, @NonNull SELECTION selection, @Nullable String groupBy, @Nullable String having, @Nullable String orderBy, @Nullable String limit) {
        return query(columns, selection.sel(), selection.args(), groupBy, having, orderBy, limit);
    }

    @NonNull
    public AbstractElementHandler<MODEL, CURSOR, SELECTION> getDatabaseElementHandler() {
        return databaseElementHandler;
    }
}
