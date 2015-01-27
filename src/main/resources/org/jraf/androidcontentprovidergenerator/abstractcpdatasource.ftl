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

public abstract class AbstractContentProviderDataSource<MODEL extends BaseModel, CURSOR extends AbstractCursor, SELECTION extends AbstractSelection<SELECTION>> extends TypedContentProviderDataSource<MODEL, CURSOR> {
    @NonNull
    private final DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler;

    /**
     * Contructor.
     *
     * @param contentResolver ContentResolver used to access the {@link android.content.ContentProvider ContentProvider}
     * @param contentProviderUri {@link android.net.Uri Uri} to access the data from the {@link android.content.ContentProvider ContentProvider}
     * @param databaseModelHandler to handle model objects read/write/query in the Content Provider.
     */
    public AbstractContentProviderDataSource(@NonNull ContentResolver contentResolver, @NonNull Uri contentProviderUri, @NonNull DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler) {
        super(contentResolver, contentProviderUri, databaseModelHandler);
        this.databaseModelHandler = databaseModelHandler;
    }

    /**
     * Contructor.
     *
     * @param context Context used to get the {@link android.content.ContentResolver ContentResolver} used to access the {@link android.content.ContentProvider ContentProvider}
     * @param contentProviderUri {@link android.net.Uri Uri} to access the data from the {@link android.content.ContentProvider ContentProvider}
     * @param databaseModelHandler to handle model objects read/write/query in the Content Provider.
     */
    public AbstractContentProviderDataSource(@NonNull Context context, @NonNull Uri contentProviderUri, @NonNull DatabaseModelHandler<MODEL, CURSOR, SELECTION> databaseModelHandler) {
        super(context, contentProviderUri, databaseModelHandler);
        this.databaseModelHandler = databaseModelHandler;
    }

    public Uri insert(MODEL model) {
        ContentValues values = databaseModelHandler.serializer.getContentValuesFromData(model, false);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return insert(values);
    }

    public boolean update(MODEL model) {
        ContentValues values = databaseModelHandler.serializer.getContentValuesFromData(model, true);
        if (values.containsKey(BaseColumns._ID)) throw new IllegalStateException("you can't write the _id, values:"+values);
        return update(model, values);
    }

    public CURSOR query(@Nullable String[] columns, @NonNull SELECTION selection, @Nullable String groupBy, @Nullable String having, @Nullable String orderBy, @Nullable String limit) {
        return query(columns, selection.sel(), selection.args(), groupBy, having, orderBy, limit);
    }

    @Override
    protected String getLimitOrderBy(@Nullable String orderBy, @NonNull String limit) {
        if (orderBy == null)
            return null;
        return super.getLimitOrderBy(orderBy, limit);
    }

    @Override
    protected Uri getLimitUri(@NonNull Uri uri, @NonNull String limit) {
        return uri.buildUpon().appendQueryParameter(BaseContentProvider.QUERY_LIMIT, limit).build();
    }

    @NonNull
    public DatabaseModelHandler<MODEL, CURSOR, SELECTION> getDatabaseModelHandler() {
        return databaseModelHandler;
    }
}
