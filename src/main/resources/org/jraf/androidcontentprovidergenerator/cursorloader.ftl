<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.Context;
<#if config.useAnnotations>
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
</#if>

import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
import org.gawst.proxy.database.base.AbstractCursorLoader;

/**
 * Simple CursorLoader for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}CursorLoader extends AbstractCursorLoader<${entity.nameCamelCase}Cursor> {
    /**
     * Default CursorLoader with all the fields in the table read.
     *
     * @param context used by {@link android.support.v4.content.Loader Loader}, cannot be {@code null}.
     * @param databaseSource the database to read items from.
     * @param selection a ${entity.nameCamelCase}Selection passed to the dataSource query, may be {@code null} to query all items in the database.
     * @param sortOrder the sorting order for the items read from the database, undefined order if {@code null}.
     */
    public ${entity.nameCamelCase}CursorLoader(<#if config.useAnnotations>@NonNull </#if>Context context, <#if config.useAnnotations>@NonNull </#if>TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource, <#if config.useAnnotations>@Nullable </#if>${entity.nameCamelCase}Selection selection, <#if config.useAnnotations>@Nullable </#if>String sortOrder) {
        this(context, databaseSource, ${entity.nameCamelCase}Columns.ALL_COLUMNS, selection, sortOrder);
    }

    /**
     * CursorLoader with a custom projection. Reading the {@link ${entity.nameCamelCase}Cursor} as a {@link ${entity.nameCamelCase}Model} may not work if you don't read the mandatory fields.
     *
     * @param context used by {@link android.support.v4.content.Loader Loader}, cannot be {@code null}.
     * @param databaseSource the database to read items from.
     * @param projection custom projection, will use all the fields if set to {@code null}.
     * @param selection a ${entity.nameCamelCase}Selection passed to the dataSource query, may be {@code null} to query all items in the database.
     * @param sortOrder the sorting order for the items read from the database, undefined order if {@code null}.
     * @see #${entity.nameCamelCase}CursorLoader(android.content.Context, org.gawst.asyncdb.source.typed.TypedDatabaseSource, ${entity.nameCamelCase}Selection, String)
     */
    public ${entity.nameCamelCase}CursorLoader(<#if config.useAnnotations>@NonNull </#if>Context context, <#if config.useAnnotations>@NonNull </#if>TypedDatabaseSource<?, ?, ${entity.nameCamelCase}Cursor> databaseSource, <#if config.useAnnotations>@Nullable </#if>String[] projection, <#if config.useAnnotations>@Nullable </#if>${entity.nameCamelCase}Selection selection, <#if config.useAnnotations>@Nullable </#if>String sortOrder) {
        super(context, databaseSource, projection == null ? ${entity.nameCamelCase}Columns.ALL_COLUMNS : projection, selection == null ? new ${entity.nameCamelCase}Selection() : selection, sortOrder);
    }
}
